import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/result.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../data/models/login_payload.dart';
import '../../domain/usecases/sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUsecase _usecase;
  final AuthenticationCubit _authCubit;

  SignInBloc({
    required AuthenticationCubit authCubit,
    required SignInUsecase usecase,
  }) : _authCubit = authCubit,
       _usecase = usecase,
       super(SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoadInProgress());
    final result = await _usecase.signInUser(payload: event.payload);
    switch (result) {
      case Ok():
        {
          await _authCubit.login(result.value);
          emit(const SignInLoadComplete());
        }
      case Error():
        {
          emit(SignInLoadFailure(exception: result.error));
        }
    }
  }
}
