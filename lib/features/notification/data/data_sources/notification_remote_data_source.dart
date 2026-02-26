import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/utils/base_response_model.dart';
import '../models/new_notif_response_model.dart';
import '../models/notif_response_model.dart';
import '../models/post_fcm_token_payload.dart';
import '../models/register_fcm_token_response_model.dart';

part 'notification_remote_data_source.g.dart';

@RestApi()
abstract class NotificationRemoteDataSource {
  factory NotificationRemoteDataSource(Dio dio, {String baseUrl}) =
      _NotificationRemoteDataSource;

  @POST("oci/register-device")
  Future<HttpResponse<RegisterFcmTokenResponseModel>> postFcmToken(
    @Body() PostFcmTokenPayload payload,
  );

  @GET("oci/notification/new")
  @Extra({"no-cache": true})
  Future<HttpResponse<NewNotifResponseModel>> getNewNotifications();

  @GET("oci/notification")
  Future<HttpResponse<NotificationResponseModel>> getNotifications({
    @Query("page") int? page,
    @Query("limit") int? limit,
  });

  @GET("oci/notification/read")
  @Extra({"no-cache": true})
  Future<HttpResponse<BaseResponseModel>> readAllNotification();

  @GET("oci/notification/read/{notification_id}")
  @Extra({"no-cache": true})
  Future<HttpResponse<BaseResponseModel>> readNotificationById({
    @Path("notification_id") required String notificationId,
  });
}
