// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import '../../../domain/repositories/push_notification_repository.dart';

// part 'push_notification_event.dart';
// part 'push_notification_state.dart';

// class PushNotificationBloc
//     extends Bloc<PushNotificationEvent, PushNotificationState> {
//   PushNotificationBloc({
//     required PushNotificationRepository notificationRepository,
//   }) : _notificationRepository = notificationRepository,
//        super(const PushNotificationState.initial()) {
//     on<NotificationOpened>(_onNotificationOpened);
//     on<NotificationInForegroundReceived>(_onNotificationInForegroundReceived);
//     _notificationRepository.onNotificationOpened.listen((notification) {
//       add(NotificationOpened(notification: notification.notification!.title!));
//     });
//     _notificationRepository.onForegroundNotification.listen((notification) {
//       add(NotificationOpened(notification: notification.title!));
//     });
//   }

//   final PushNotificationRepository _notificationRepository;

//   void _onNotificationOpened(
//     NotificationOpened event,
//     Emitter<PushNotificationState> emit,
//   ) {
//     emit(
//       state.copyWith(
//         notification: event.notification,
//         appState: AppState.background,
//       ),
//     );
//   }

//   void _onNotificationInForegroundReceived(
//     NotificationInForegroundReceived event,
//     Emitter<PushNotificationState> emit,
//   ) {
//     emit(
//       state.copyWith(
//         notification: event.notification.title,
//         appState: AppState.foreground,
//       ),
//     );
//   }
// }
