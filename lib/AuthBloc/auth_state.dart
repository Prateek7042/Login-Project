part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

//Init State
final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

//Loading state
final class LoadingState extends AuthState{
  @override
  List<Object> get props => [];
}

//Success login state
final class Authenticated extends AuthState{
  final Users users;
  const Authenticated(this.users);
  @override
  List<Object> get props => [users];
}

//In case when there is an error
final class FailureState extends AuthState{
  final String error;
  const FailureState(this.error);
  @override
  List<Object> get props => [error];
}

//Logout state
final class UnAuthenticated extends AuthState{
  @override
  List<Object> get props => [];
}

final class SuccessRegister extends AuthState{
  @override
  List<Object> get props => [];
}