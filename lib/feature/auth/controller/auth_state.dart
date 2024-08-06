part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final dynamic response;

  AuthSuccess(this.response);
}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure(this.errorMessage);

}
