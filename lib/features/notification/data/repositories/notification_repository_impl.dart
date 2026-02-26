import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_udid/flutter_udid.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/networks/networks.dart';
import '../../../../core/utils/base_response_model.dart';
import '../../../../core/utils/result.dart';
import '../../domain/repositories/notification_repository.dart';
import '../data_sources/notification_remote_data_source.dart';
import '../models/new_notif_response_model.dart';
import '../models/notif_response_model.dart';
import '../models/post_fcm_token_payload.dart';
import '../models/register_fcm_token_response_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _notificationRemoteDataSource;
  final TokenManager _tokenManager;

  const NotificationRepositoryImpl({
    required NotificationRemoteDataSource notificationRemoteDataSource,
    required TokenManager tokenManager,
  }) : _notificationRemoteDataSource = notificationRemoteDataSource,
       _tokenManager = tokenManager;

  @override
  Future<Result<RegisterFcmTokenResponseModel>> registerDeviceFcmToken({
    required String fcmToken,
  }) async {
    try {
      /// get email
      final AuthToken? authToken = await _tokenManager.getAuthToken();
      if (authToken == null) {
        return Result.error(
          AppException(
            "Register new FCM token failed. Auth token not found",
            statusCode: HttpStatus.forbidden,
          ),
        );
      }

      if (authToken.isExpired) {
        return Result.error(
          AppException(
            "Register new FCM token failed. Auth token is expired",
            statusCode: HttpStatus.forbidden,
          ),
        );
      }

      final String? email = authToken.userData?.email;

      if (email == null || email.isEmpty) {
        return Result.error(
          AppException(
            "Register new FCM token failed. Cannot find user's email",
            statusCode: HttpStatus.forbidden,
          ),
        );
      }

      final storedFcmToken = await _tokenManager.getFcmToken();
      if (storedFcmToken != null) {
        print("Got stored FCM token. Token: $storedFcmToken");
        if (storedFcmToken == fcmToken) {
          print(
            "stored FCM token is equal to fcm token, returning OK with token: $storedFcmToken",
          );
          RegisterFcmTokenResponseModel value = RegisterFcmTokenResponseModel(
            message: "OK",
            status: HttpStatus.ok,
          );
          return Result.ok(value);
        } else {
          print("Stored FCM token is not equal, replacing stored token");
          await _tokenManager.clearFcmToken();
          await _tokenManager.saveFcmToken(fcmToken);
        }
      } else {
        print(
          "Stored FCM token is null, saving new fcm token with token: $fcmToken",
        );
        await _tokenManager.saveFcmToken(fcmToken);
      }

      /// get uuid device
      String udid = await FlutterUdid.consistentUdid;

      final PostFcmTokenPayload payload = PostFcmTokenPayload(
        email: email,
        token: fcmToken,
        deviceId: udid,
      );

      final httpResponse = await _notificationRemoteDataSource.postFcmToken(
        payload,
      );
      if (httpResponse.data.status != HttpStatus.ok) {
        return Result.error(
          NetworkException(
            httpResponse.data.message ?? "Unknown error",
            statusCode: httpResponse.data.status,
          ),
        );
      }
      return Result.ok(httpResponse.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<Result<NewNotifResponseModel>> getNewNotifications() async {
    try {
      final httpResponse =
          await _notificationRemoteDataSource.getNewNotifications();
      if (httpResponse.data.status != HttpStatus.ok) {
        throw Result.error(
          NetworkException(
            httpResponse.data.message ?? "Unknown error",
            statusCode: httpResponse.data.status,
          ),
        );
      }
      return Result.ok(httpResponse.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<Result<NotificationResponseModel>> getNotifications({
    int? page,
    int? limit,
  }) async {
    try {
      final httpResponse = await _notificationRemoteDataSource.getNotifications(
        page: page,
        limit: limit,
      );
      if (httpResponse.data.status != HttpStatus.ok) {
        throw Result.error(
          NetworkException(
            httpResponse.data.message ?? "Unknown error",
            statusCode: httpResponse.data.status,
          ),
        );
      }
      return Result.ok(httpResponse.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<Result<BaseResponseModel>> readAllNotification() async {
    try {
      final httpResponse =
          await _notificationRemoteDataSource.readAllNotification();
      if (httpResponse.data.status != HttpStatus.ok) {
        throw Result.error(
          NetworkException(
            httpResponse.data.message ?? "Unknown error",
            statusCode: httpResponse.data.status,
          ),
        );
      }
      return Result.ok(httpResponse.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }

  @override
  Future<Result<BaseResponseModel>> readNotificationById({
    required String notificationId,
  }) async {
    try {
      final httpResponse = await _notificationRemoteDataSource
          .readNotificationById(notificationId: notificationId);
      if (httpResponse.data.status != HttpStatus.ok) {
        throw Result.error(
          NetworkException(
            httpResponse.data.message ?? "Unknown error",
            statusCode: httpResponse.data.status,
          ),
        );
      }
      return Result.ok(httpResponse.data);
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    }
  }
}
