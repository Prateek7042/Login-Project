part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent{
  final String username;
  final String password;
  const LoginEvent(this.username, this.password);
  @override
  List<Object> get props => [username, password];
}

class RegisterEvent extends AuthEvent{
  final Users users;
  const RegisterEvent(this.users);
  @override
  List<Object> get props => [];
}

class UnAuthenticatedEvent extends AuthEvent{
  @override
  List<Object> get props => [];
}