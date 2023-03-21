part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  String email, password;
  LoginEvent({required this.email , required this.password});
}

class RegisterEvent extends AuthEvent {}
