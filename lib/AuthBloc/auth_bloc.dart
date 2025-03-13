import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_project/Models/users.dart';
import '../../DatabaseHelper/repository.dart';
import '../../Models/users.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;
  AuthBloc(this.repository) : super(AuthInitial()) {

    //Login Event
    on<LoginEvent>((event, emit)async {
      emit(LoadingState());
      try{
        await Future.delayed(const Duration(seconds: 2));
        final authenticated = await repository.authenticate(
            Users(username: event.username, password: event.password));
        if(authenticated){
          //If success login - then save current logged in user
          Users usr = await repository.getLoggedInUser(event.username);
          emit(Authenticated(usr));
        }else{
          // Failed login - then show error message
          emit(const FailureState("Username or password is incorrect"));
        }
      }catch(e){
        emit(FailureState(e.toString()));
      }

    });

    //Sign up Event
    on<RegisterEvent>((event, emit)async{
      emit(LoadingState());

      try{
        await Future.delayed(const Duration(seconds: 2));
        final res = await repository.registerUser(
            Users(
                fullName: event.users.fullName,
                email: event.users.email,
                username: event.users.username,
                password: event.users.password));

        if(res>0){
          emit(SuccessRegister());
          Users usr = await repository.getLoggedInUser(event.users.username);
          emit(Authenticated(usr));
        }else{
          emit(FailureState("User ${event.users.username} already exists"));
        }

      }catch(e){
        emit(FailureState(e.toString()));
      }

    });

    //Logout event
    on<UnAuthenticatedEvent>((event, emit){
      emit(UnAuthenticated());
    });

    //Logout Event
  }
}