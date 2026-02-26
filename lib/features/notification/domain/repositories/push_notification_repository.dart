// import 'package:firebase_messaging/firebase_messaging.dart';

// import '../../data/models/push_notification_topic.dart';

// abstract class PushNotificationRepository {
//   /// Subscribe to topic in background.
//   Future<void> subscribeToTopic(PushNotificationTopic topic);

//   /// Unsubscribe from topic in background.
//   Future<void> unsubscribeFromTopic(PushNotificationTopic topic);

//   /// Returns a [Stream] that emits when an incoming [Notification] is
//   /// received whilst the Flutter instance is in the foreground.
//   Stream<RemoteNotification> get onForegroundNotification;

//   /// Returns a [Stream] that emits when a user presses a [Notification]
//   /// message displayed via FCM.
//   ///
//   /// If your app is opened via a notification whilst the app is terminated,
//   /// see [FirebaseMessaging.getInitialMessage].
//   Stream<RemoteMessage> get onNotificationOpened;
// }
