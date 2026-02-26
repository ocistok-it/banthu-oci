part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInLoadInProgress extends SignInState {}

final class SignInLoadComplete extends SignInState {
  const SignInLoadComplete();

  @override
  List<Object> get props => [];
}

final class SignInLoadFailure extends SignInState {
  final Exception exception;

  const SignInLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];
}
