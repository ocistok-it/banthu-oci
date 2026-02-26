// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';

// import '../../../../core/dependencies/injector.dart';
// import '../../../../core/utils/result.dart';
// import '../../domain/repositories/push_notification_repository.dart';
// import '../../domain/usecases/notification_usecase.dart';
// import '../models/push_notification_topic.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint('Handling background message: ${message.messageId}');
//   debugPrint('${message.data}');
// }

// class PushNotificationRepositoryImpl implements PushNotificationRepository {
//   PushNotificationRepositoryImpl({
//     FirebaseMessaging? firebaseMessaging,
//     Stream<RemoteMessage>? onNotificationOpened,
//     Stream<RemoteMessage>? onForegroundNotification,
//     NotificationUsecase? notificationUsecase,
//     FlutterLocalNotificationsPlugin? localNotifications,
//   }) : _notificationUsecase = notificationUsecase ?? sl<NotificationUsecase>(),
//        _localNotifications =
//            localNotifications ?? FlutterLocalNotificationsPlugin(),
//        _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
//        _onForegroundNotification =
//            onForegroundNotification ?? FirebaseMessaging.onMessage,
//        _onNotificationOpenedController = BehaviorSubject<RemoteMessage>() {
//     _initialize(onNotificationOpened ?? FirebaseMessaging.onMessageOpenedApp);
//   }

//   final FirebaseMessaging _firebaseMessaging;
//   final Stream<RemoteMessage> _onForegroundNotification;
//   final BehaviorSubject<RemoteMessage> _onNotificationOpenedController;
//   final NotificationUsecase _notificationUsecase;
//   final FlutterLocalNotificationsPlugin _localNotifications;

//   Future<void> _initialize(Stream<RemoteMessage> onNotificationOpened) async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     if (Platform.isIOS) {
//       await _firebaseMessaging.getAPNSToken();
//     }

//     final token = await _firebaseMessaging.getToken();
//     await _sendTokenToServer(token!);

//     final initialMessage = await _firebaseMessaging.getInitialMessage();

//     if (initialMessage != null) {
//       _onMessageOpened(initialMessage);
//     }
//     onNotificationOpened.listen(_onMessageOpened);

//     // Initialize Local Notifications
//     await _initializeLocalNotifications();

//     // Handle notification permissions
//     await _requestPermissions();
//   }

//   Future<void> _initializeLocalNotifications() async {
//     const androidSettings = AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     );
//     const iosSettings = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//     );

//     const initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );

//     await _localNotifications.initialize(initSettings);
//   }

//   Future<void> _requestPermissions() async {
//     // Request permission for Firebase Messaging
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       provisional: false,
//     );

//     // Request permission for Local Notifications (Android)
//     if (Platform.isAndroid) {
//       await _localNotifications
//           .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin
//           >()
//           ?.requestNotificationsPermission();
//     }
//     if (Platform.isIOS) {
//       await _localNotifications
//           .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin
//           >()
//           ?.requestPermissions(alert: true, badge: true, sound: true);
//     }
//   }

//   Future<void> _sendTokenToServer(String token) async {
//     final result = await _notificationUsecase.registerDeviceFcmToken(
//       fcmToken: token,
//     );

//     switch (result) {
//       case Ok():
//         debugPrint(
//           "[NotificationService] : FCM token's sent! FCM Token: $token",
//         );
//         return;
//       case Error():
//         debugPrint("[NotificationService] : ${result.error.toString()}");
//         return;
//     }
//   }

//   void _onMessageOpened(RemoteMessage message) {
//     final notification = message.notification;
//     if (notification != null) {
//       _onNotificationOpenedController.sink.add(message);
//     }
//   }

//   @override
//   Stream<RemoteNotification> get onForegroundNotification {
//     return _onForegroundNotification.mapNotNull((message) {
//       final notification = message.notification;
//       if (notification == null) {
//         return null;
//       }
//       return notification;
//     });
//   }

//   @override
//   Stream<RemoteMessage> get onNotificationOpened {
//     return _onNotificationOpenedController.stream;
//   }

//   @override
//   Future<void> subscribeToTopic(PushNotificationTopic topic) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> unsubscribeFromTopic(PushNotificationTopic topic) {
//     throw UnimplementedError();
//   }
// }
