part of 'notification_bloc.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class NotificationLoadInProgress extends NotificationState {}

final class NotificationLoadComplete extends NotificationState {
  final List<NotificationModel> notifications;
  final int globalStartIndex;
  final int startPage;
  final int? jumpToLocalIndex;
  final bool isPagingForward;
  final bool isPagingBackward;
  final bool hasReachedMax;

  const NotificationLoadComplete({
    required this.notifications,
    required this.globalStartIndex,
    required this.startPage,
    this.jumpToLocalIndex,
    this.isPagingForward = false,
    this.isPagingBackward = false,
    this.hasReachedMax = false,
  });

  NotificationLoadComplete copyWith({
    List<NotificationModel>? notifications,
    int? globalStartIndex,
    int? startPage,
    int? jumpToLocalIndex,
    bool? isPagingForward,
    bool? isPagingBackward,
    bool? hasReachedMax,
  }) {
    return NotificationLoadComplete(
      notifications: notifications ?? this.notifications,
      globalStartIndex: globalStartIndex ?? this.globalStartIndex,
      startPage: startPage ?? this.startPage,
      jumpToLocalIndex: jumpToLocalIndex,
      isPagingForward: isPagingForward ?? this.isPagingForward,
      isPagingBackward: isPagingBackward ?? this.isPagingBackward,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    notifications,
    globalStartIndex,
    startPage,
    jumpToLocalIndex,
    isPagingForward,
    isPagingBackward,
    hasReachedMax,
  ];
}

final class NotificationLoadFailure extends NotificationState {
  final String errorMessage;

  const NotificationLoadFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}
