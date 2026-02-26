import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: unused_import
import 'package:go_router/go_router.dart';

import '../../core/dependencies/injector.dart';
import '../../core/exceptions/app_exceptions.dart';
import '../../core/utils/result.dart';
import 'domain/usecases/notification_usecase.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
  debugPrint('${message.data}');
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotifications;
  final FirebaseMessaging _firebaseMessaging;
  final NotificationUsecase _notificationUsecase;

  // Singleton instance
  static NotificationService? _instance;

  NotificationService._({
    required FlutterLocalNotificationsPlugin localNotifications,
    required FirebaseMessaging firebaseMessaging,
    required NotificationUsecase notificationUsecase,
  }) : _localNotifications = localNotifications,
       _firebaseMessaging = firebaseMessaging,
       _notificationUsecase = notificationUsecase;

  static NotificationService get instance {
    _instance ??= NotificationService._(
      localNotifications: FlutterLocalNotificationsPlugin(),
      firebaseMessaging: FirebaseMessaging.instance,
      notificationUsecase: sl<NotificationUsecase>(),
    );
    return _instance!;
  }

  // Initialize both local notifications and Firebase messaging
  Future<void> initialize() async {
    try {
      // Initialize Firebase Messaging
      await _initializeFirebaseMessaging();

      // Initialize Local Notifications
      await _initializeLocalNotifications();

      // Handle notification permissions
      await _requestPermissions();

      // Set up notification handlers
      _setupNotificationHandlers();
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<void> _initializeFirebaseMessaging() async {
    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _setupToken();
  }

  Future<void> _setupToken() async {
    // Get APNS token
    final apnstoken = await _firebaseMessaging.getAPNSToken();
    debugPrint('APNs token: $apnstoken');

    // Get FCM token
    final token = await _firebaseMessaging.getToken();
    debugPrint('FCM Token: $token');

    // Save token to your backend
    if (token != null) {
      await _handleFcmToken(token);
    }

    // Listen to token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) async {
      if (token.isNotEmpty) {
        await _handleFcmToken(token);
      }
    });
  }

  Future<void> _handleFcmToken(String token) async {
    final result = await _notificationUsecase.registerDeviceFcmToken(
      fcmToken: token,
    );

    switch (result) {
      case Ok():
        debugPrint(
          "[NotificationService] : FCM token's sent! FCM Token: $token",
        );
        return;
      case Error():
        debugPrint("[NotificationService] : ${result.error.toString()}");
        return;
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  Future<void> _requestPermissions() async {
    // Request permission for Firebase Messaging
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // Request permission for Local Notifications (Android)
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
    if (Platform.isIOS) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  void _setupNotificationHandlers() async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification open events when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpen);

    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      try {
        final initialMsg = InitialMessage.fromJson(initialMessage.data);
        if (initialMsg.type == "product") {
          await Future.delayed(const Duration(seconds: 3));
          // rootNavigatorKey.currentContext?.pushNamed(
          //   'product',
          //   pathParameters: {
          //     'store': initialMsg.store!,
          //     'id': initialMsg.productId!,
          //   },
          // );
        }
      } catch (e) {
        debugPrint("getInitialMessage err $e");
      }
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    // Show local notification for foreground messages
    final notification = message.notification;
    print("on _handleForegroundMessage");
    print("got notification: ${notification?.toMap()}");
    if (notification != null) {
      await showNotification(
        id: message.hashCode,
        title: notification.title,
        body: notification.body,
        payload: message.data.toString(),
      );
    }
  }

  void _handleNotificationOpen(RemoteMessage message) {
    // Handle notification tap when app is in background
    _onNotificationTapped(
      NotificationResponse(
        notificationResponseType: NotificationResponseType.selectedNotification,
        payload: message.data.toString(),
      ),
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      // Handle the notification tap based on payload
      final payload = response.payload!;
      _handleNotificationPayload(payload);
    }
  }

  Future<void> showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
  }) async {
    final androidDetails = const AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Default notification channel',
      importance: Importance.max,
      priority: Priority.max,
      fullScreenIntent: true,
    );

    final iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(id, title, body, details, payload: payload);
  }

  Future<void> _handleNotificationPayload(String payload) async {
    // Parse payload and handle navigation
    try {
      print(payload);
      payload = payload.replaceAll('{', '{"');
      payload = payload.replaceAll(': ', '": "');
      payload = payload.replaceAll(', ', '", "');
      payload = payload.replaceAll('}', '"}');
      print(payload);
      final Map<String, dynamic> data = jsonDecode(payload);
      if (data['type'] == 'product') {
        // router.pushNamed("product");
        // rootNavigatorKey.currentContext?.pushNamed(
        //   'product',
        //   pathParameters: {'store': data["store"], 'id': data["product_id"]},
        // );
      }
    } catch (e) {
      debugPrint('Failed to handle notification payload: $e');
    }
  }

  // Clean up resources
  Future<void> dispose() async {
    // Cancel any active notifications
    await _localNotifications.cancelAll();
  }
}

class InitialMessage {
  final String? productId;
  final String? type;
  final String? store;

  InitialMessage({this.productId, this.type, this.store});

  factory InitialMessage.fromRawJson(String str) =>
      InitialMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InitialMessage.fromJson(Map<String, dynamic> json) => InitialMessage(
    productId: json["product_id"],
    type: json["type"],
    store: json["store"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "type": type,
    "store": store,
  };
}
