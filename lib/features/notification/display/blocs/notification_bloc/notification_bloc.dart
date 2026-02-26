import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/result.dart';
import '../../../data/models/notif_response_model.dart';
import '../../../domain/usecases/notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required NotificationUsecase usecase})
    : _usecase = usecase,
      super(NotificationInitial()) {
    on<InitialNotificationRequested>(_onInitialNotificationRequested);
    on<NextNotificationRequested>(_onNextNotificationRequested);
    on<PrevNotificationRequested>(_onPrevNotificationRequested);
    on<MarkAllAsReadRequested>(_onMarkAllAsReadRequested);
  }

  final NotificationUsecase _usecase;

  static const int pageSize = 10;
  static const int windowPageCount = 3;
  static const int windowSize = pageSize * windowPageCount;

  Future<void> _onInitialNotificationRequested(
    InitialNotificationRequested event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      List<NotificationModel> initialNotifications = [];
      for (int i = 1; i <= windowPageCount; i++) {
        final result = await _usecase.getNotifications(
          page: i,
          limit: pageSize,
        );
        switch (result) {
          case Ok():
            {
              initialNotifications.addAll(result.value.data!.notification!);
            }
          case Error():
            {
              break;
            }
        }
      }
      emit(
        NotificationLoadComplete(
          notifications: initialNotifications,
          globalStartIndex: 0,
          startPage: 1,
        ),
      );
    } catch (e) {
      emit(NotificationLoadFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onNextNotificationRequested(
    NextNotificationRequested event,
    Emitter<NotificationState> emit,
  ) async {
    if (state is! NotificationLoadComplete) return;
    final currentState = state as NotificationLoadComplete;

    if (currentState.isPagingForward || currentState.hasReachedMax) return;

    emit(currentState.copyWith(isPagingForward: true));

    try {
      final nextPageToFetch = currentState.startPage + windowPageCount;
      final result = await _usecase.getNotifications(
        page: nextPageToFetch,
        limit: pageSize,
      );
      switch (result) {
        case Ok():
          {
            if (result.value.data!.notification!.isEmpty) {
              emit(
                currentState.copyWith(
                  isPagingForward: false,
                  hasReachedMax: true,
                ),
              );
              return;
            }

            final updatedNotifications =
                List<NotificationModel>.from(currentState.notifications)
                  ..addAll(result.value.data!.notification!)
                  ..removeRange(0, pageSize);

            final newStartPage = currentState.startPage + 1;
            final newGlobalStartIndex = (newStartPage - 1) * pageSize;

            const newLocalIndex = pageSize * (windowPageCount - 1);

            emit(
              currentState.copyWith(
                notifications: updatedNotifications,
                globalStartIndex: newGlobalStartIndex,
                startPage: newStartPage,
                jumpToLocalIndex: newLocalIndex,
                isPagingForward: false,
              ),
            );
          }
        case Error():
          {
            emit(
              currentState.copyWith(
                isPagingForward: false,
                hasReachedMax: true,
              ),
            );
            return;
          }
      }
    } catch (e) {
      emit(NotificationLoadFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onPrevNotificationRequested(
    PrevNotificationRequested event,
    Emitter<NotificationState> emit,
  ) async {}

  Future<void> _onMarkAllAsReadRequested(
    MarkAllAsReadRequested event,
    Emitter<NotificationState> emit,
  ) async {
    if (state is! NotificationLoadComplete) return;
    final currentState = state as NotificationLoadComplete;

    final result = await _usecase.readAllNotification();

    switch (result) {
      case Ok():
        {
          final updatedNotifications = List<NotificationModel>.from(
            currentState.notifications,
          );
          for (var i = 0; i < updatedNotifications.length; i++) {
            updatedNotifications[i].copyWith(isNew: false);
          }
          emit(currentState.copyWith(notifications: updatedNotifications));
        }
      case Error():
        {
          emit(currentState);
        }
    }
  }
}
