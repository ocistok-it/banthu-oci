part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

// final class NotificationRequested extends NotificationEvent {}
final class InitialNotificationRequested extends NotificationEvent {}

final class NextNotificationRequested extends NotificationEvent {}

final class PrevNotificationRequested extends NotificationEvent {}

final class MarkAllAsReadRequested extends NotificationEvent {}
