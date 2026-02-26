import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  factory NetworkException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          'Connection timeout',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          'No internet connection',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response);
      case DioExceptionType.cancel:
        return NetworkException(
          'Request cancelled',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.unknown:
      default:
        if (error.error.toString().contains('SocketException')) {
          return NetworkException(
            'No internet connection',
            statusCode: error.response?.statusCode,
          );
        }
        return NetworkException(
          'Unexpected error occurred',
          statusCode: error.response?.statusCode,
        );
    }
  }

  static NetworkException _handleStatusCode(Response? response) {
    final statusCode = response?.statusCode;
    final message = response?.statusMessage ?? 'Something went wrong';

    switch (statusCode) {
      case 400:
        return NetworkException('Bad request', statusCode: statusCode);
      case 401:
        return NetworkException('Unauthorized', statusCode: statusCode);
      case 403:
        return NetworkException('Forbidden', statusCode: statusCode);
      case 404:
        return NetworkException('Not found', statusCode: statusCode);
      case 500:
      case 501:
      case 502:
      case 503:
        return NetworkException('Server error', statusCode: statusCode);
      default:
        return NetworkException(message, statusCode: statusCode);
    }
  }

  @override
  String toString() =>
      'An error occurred : $message (Status code: $statusCode)';
}
