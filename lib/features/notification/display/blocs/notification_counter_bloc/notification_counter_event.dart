part of 'notification_counter_bloc.dart';

sealed class NotificationCounterEvent extends Equatable {
  const NotificationCounterEvent();

  @override
  List<Object> get props => [];
}

final class NotificationCounterRequested extends NotificationCounterEvent {
  const NotificationCounterRequested();
}
