part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailed extends AuthState {
  String errorMessage;
  RegisterFailed({required this.errorMessage});
}
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailed extends AuthState {
  String errorMessage;
  LoginFailed({required this.errorMessage});
}


