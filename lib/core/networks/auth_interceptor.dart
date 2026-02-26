import 'package:dio/dio.dart';

import '../../features/sign_in/data/models/user_decoded_model.dart';
import '../dependencies/injector.dart';
import 'token_manager.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager _tokenManager;
  Future<String?>? _refreshTokenFuture;

  AuthInterceptor(this._tokenManager);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_shouldSkipAuth(options)) {
      handler.next(options);
      return;
    }

    final AuthToken? authToken = await _tokenManager.getAuthToken();

    if (authToken != null && authToken.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${authToken.accessToken}';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 403) {
      return handler.next(err);
    }

    if (_isUnauthorized(err) && _shouldRefresh(err.requestOptions)) {
      // Attempt refresh if not already happening
      _refreshTokenFuture ??= _refreshAccessToken();

      final newToken = await _refreshTokenFuture;
      if (newToken != null) {
        // Retry the original request
        final clonedRequest = _retryRequest(err.requestOptions, newToken);
        try {
          final response = await sl<Dio>().fetch(clonedRequest);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(e as DioException);
        }
      }
      // If refresh fails, newToken == null => pass the 401 up
    }
    return handler.next(err);
  }

  bool _isUnauthorized(DioException err) {
    return err.response?.statusCode == 401;
  }

  bool _shouldSkipAuth(RequestOptions options) {
    return options.path.contains('/login') ||
        options.path.contains('/register') ||
        options.extra['skip_auth'] == true;
  }

  Future<String?> _refreshAccessToken() async {
    try {
      final newAccessToken = AuthToken(
        accessToken: "",
        refreshToken: "",
        expiresIn: DateTime(2099),
        userData: const UserData(),
      );

      await _tokenManager.saveAuthToken(newAccessToken);
      return newAccessToken.accessToken;
    } catch (e) {
      // If fail, remove token or force user to re-log
      await _tokenManager.clearAuthToken();
      return null;
    } finally {
      // Allow future refresh attempts next time 401 is encountered
      _refreshTokenFuture = null;
    }
  }

  RequestOptions _retryRequest(RequestOptions requestOptions, String newToken) {
    final newHeaders = Map<String, dynamic>.from(requestOptions.headers);
    newHeaders['Authorization'] = 'Bearer $newToken';
    return requestOptions.copyWith(headers: newHeaders);
  }

  bool _shouldRefresh(RequestOptions requestOptions) {
    // Avoid refreshing again if it's the refresh token call
    return !requestOptions.path.contains('/refresh');
  }
}
