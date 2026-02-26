part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

final class SignInRequested extends SignInEvent {
  final SignInPayload payload;

  const SignInRequested({required this.payload});

  @override
  List<Object> get props => [payload];
}
