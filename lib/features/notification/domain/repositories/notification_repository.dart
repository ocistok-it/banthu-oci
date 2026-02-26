import '../../../../core/utils/base_response_model.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/new_notif_response_model.dart';
import '../../data/models/notif_response_model.dart';
import '../../data/models/register_fcm_token_response_model.dart';

abstract interface class NotificationRepository {
  Future<Result<RegisterFcmTokenResponseModel>> registerDeviceFcmToken({
    required String fcmToken,
  });

  Future<Result<NewNotifResponseModel>> getNewNotifications();

  Future<Result<NotificationResponseModel>> getNotifications({
    int? page,
    int? limit,
  });

  Future<Result<BaseResponseModel>> readAllNotification();

  Future<Result<BaseResponseModel>> readNotificationById({
    required String notificationId,
  });
}
