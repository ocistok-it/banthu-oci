import 'package:dio/dio.dart';
import 'auth_interceptor.dart';
import 'cache_interceptor.dart';
import 'cache_manager.dart';
import 'meta_data_interceptor.dart';
import 'network_connectivity.dart';
import 'token_manager.dart';

class AppDio {
  final Dio _dio;
  final TokenManager _tokenManager;
  final CacheManager _cacheManager;
  final NetworkConnectivity _connectivity;
  // ignore: unused_field
  final String _baseUrl;
  String _langcode;

  AppDio({
    required String baseUrl,
    required TokenManager tokenManager,
    required CacheManager cacheManager,
    required NetworkConnectivity connectivity,
    required String langcode,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) : _baseUrl = baseUrl,
       _tokenManager = tokenManager,
       _cacheManager = cacheManager,
       _connectivity = connectivity,
       _langcode = langcode,
       _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout,
           receiveTimeout: receiveTimeout,
           contentType: 'application/json',
         ),
       ) {
    _setupInterceptors();
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(MetaDataInterceptor(langcode: _langcode));

    _dio.interceptors.add(AuthInterceptor(_tokenManager));

    _dio.interceptors.add(CacheInterceptor(_cacheManager, _connectivity));

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        requestBody: true,
        error: true,
      ),
    );
  }

  void updateBaseUrl(String newBaseUrl, String newLangcode) {
    _langcode = newLangcode;
    _dio.options.baseUrl = newBaseUrl;
  }
}
