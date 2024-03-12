// presentation/cubit/login_state.dart
part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponse response;
  final String deliveryName;

  LoginLoaded({
    required this.response,
    required this.deliveryName,
  });

  @override
  List<Object> get props => [response, deliveryName];
}

class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});

  @override
  List<Object> get props => [message];
}
