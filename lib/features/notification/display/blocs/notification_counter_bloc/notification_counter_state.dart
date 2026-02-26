part of 'notification_counter_bloc.dart';

final class NotificationCounterState extends Equatable {
  final AppStatus status;
  final int counter;

  const NotificationCounterState({
    this.status = AppStatus.initial,
    this.counter = 0,
  });

  NotificationCounterState copyWith({AppStatus? status, int? counter}) {
    return NotificationCounterState(
      status: status ?? this.status,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [status, counter];
}
