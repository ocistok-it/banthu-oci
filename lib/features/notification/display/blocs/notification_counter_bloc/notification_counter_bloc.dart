import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/constants/app_constants.dart';
import '../../../../../core/utils/result.dart';
import '../../../domain/usecases/notification_usecase.dart';

part 'notification_counter_state.dart';
part 'notification_counter_event.dart';

class NotificationCounterBloc
    extends Bloc<NotificationCounterEvent, NotificationCounterState> {
  final NotificationUsecase _usecase;

  NotificationCounterBloc({required NotificationUsecase usecase})
    : _usecase = usecase,
      super(const NotificationCounterState()) {
    on<NotificationCounterRequested>(_onNotificationCounterRequested);
  }

  Future<void> _onNotificationCounterRequested(
    NotificationCounterRequested event,
    Emitter<NotificationCounterState> emit,
  ) async {
    print("get counter");
    emit(state.copyWith(status: AppStatus.loading));
    final result = await _usecase.getNewNotifications();
    switch (result) {
      case Ok():
        {
          emit(
            state.copyWith(
              status: AppStatus.complete,
              counter: result.value.data.total,
            ),
          );
        }
      case Error():
        {
          emit(state.copyWith(status: AppStatus.failure));
        }
    }
  }
}
