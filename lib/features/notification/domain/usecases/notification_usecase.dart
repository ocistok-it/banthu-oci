import '../../../../core/utils/base_response_model.dart';
import '../../../../core/utils/result.dart';
import '../../data/models/new_notif_response_model.dart';
import '../../data/models/notif_response_model.dart';
import '../../data/models/register_fcm_token_response_model.dart';
import '../repositories/notification_repository.dart';

class NotificationUsecase {
  final NotificationRepository _notificationRepository;

  const NotificationUsecase({
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<Result<RegisterFcmTokenResponseModel>> registerDeviceFcmToken({
    required String fcmToken,
  }) async =>
      await _notificationRepository.registerDeviceFcmToken(fcmToken: fcmToken);

  Future<Result<NewNotifResponseModel>> getNewNotifications() async =>
      await _notificationRepository.getNewNotifications();

  Future<Result<NotificationResponseModel>> getNotifications({
    int? page,
    int? limit,
  }) async =>
      await _notificationRepository.getNotifications(page: page, limit: limit);

  Future<Result<BaseResponseModel>> readAllNotification() async =>
      await _notificationRepository.readAllNotification();

  Future<Result<BaseResponseModel>> readNotificationById({
    required String notificationId,
  }) async => await _notificationRepository.readNotificationById(
    notificationId: notificationId,
  );
}
