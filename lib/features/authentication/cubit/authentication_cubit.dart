import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../core/networks/token_manager.dart';
import '../../notification/notification_service.dart';
import '../../sign_in/data/models/login_response_model.dart';
import '../../sign_in/data/models/user_decoded_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required TokenManager tokenManager})
    : _tokenManager = tokenManager,
      super(const AuthenticationState.unauthenticated());

  final TokenManager _tokenManager;

  Future<void> checkAuthentication() async {
    final authToken = await _tokenManager.getAuthToken();

    // Handle null or empty token cases
    if (_isInvalidToken(authToken)) {
      await _clearTokenAndEmitUnauthenticated();
      return;
    }

    // Handle expired token
    if (authToken!.isExpired) {
      await _clearTokenAndEmitUnauthenticated();
      return;
    }

    // Handle invalid user data
    if (_isInvalidUserData(authToken.userData)) {
      await _clearTokenAndEmitUnauthenticated();
      return;
    }

    // Check verification status
    if (!authToken.userData!.isVerified!) {
      emit(const AuthenticationState.unverified());
      return;
    }

    // Token is valid and user is verified
    emit(const AuthenticationState.authenticated());
  }

  Future<void> login(LoginResponseModel loginResponse) async {
    // Validate required login response fields
    if (!_isValidLoginResponse(loginResponse)) {
      emit(const AuthenticationState.unauthenticated());
      return;
    }

    // Check if token is expired before processing
    if (JwtDecoder.isExpired(loginResponse.accessToken!)) {
      emit(const AuthenticationState.unauthenticated());
      return;
    }

    try {
      // Create auth token from login response
      final authToken = await _createAuthTokenFromResponse(loginResponse);
      await _tokenManager.saveAuthToken(authToken);

      // Register FCM token for the user
      await NotificationService.instance.initialize();

      // Emit appropriate state based on user verification
      _emitAuthenticationStateForUser(authToken.userData);
    } catch (e) {
      // Handle token decoding or parsing errors
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<void> logout() async {
    if (state.status == AuthStatus.unauthenticated ||
        state.status == AuthStatus.unknown) {
      return;
    }
    await _tokenManager.clearAuthToken();
    await _tokenManager.clearFcmToken();
    emit(const AuthenticationState.unauthenticated());
  }

  // Helper methods for cleaner logic
  bool _isInvalidToken(AuthToken? token) {
    return token == null || token == AuthToken.empty();
  }

  bool _isInvalidUserData(UserData? userData) {
    return userData == null || userData == UserData.empty();
  }

  bool _isValidLoginResponse(LoginResponseModel response) {
    return response.accessToken != null &&
        response.refreshToken != null &&
        response.exp != null;
  }

  Future<AuthToken> _createAuthTokenFromResponse(
    LoginResponseModel response,
  ) async {
    final rawDecodedToken = JwtDecoder.decode(response.accessToken!);
    final decodedToken = UserDecodedModel.fromJson(rawDecodedToken);
    final userData = decodedToken.data!;

    return AuthToken(
      accessToken: response.accessToken!,
      refreshToken: response.refreshToken!,
      expiresIn: DateTime.fromMillisecondsSinceEpoch(response.exp! * 1000),
      userData: userData,
    );
  }

  void _emitAuthenticationStateForUser(UserData? userData) {
    if (userData?.isVerified == true) {
      emit(const AuthenticationState.authenticated());
    } else {
      emit(const AuthenticationState.unverified());
    }
  }

  Future<void> _clearTokenAndEmitUnauthenticated() async {
    await _tokenManager.clearAuthToken();
    emit(const AuthenticationState.unauthenticated());
  }
}
