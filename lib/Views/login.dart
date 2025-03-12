import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_project/Views/signup.dart';
import '../AuthBloc/auth_bloc.dart';
import '../Constants/env.dart';
import '../components/button.dart';
import '../components/textfield.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is Authenticated){
          Env.gotoReplacement(context, const Home());
        }else if(state is FailureState){
          Env.snackBar(context, state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width *.6,
                      child: Hero(
                          tag: "image",
                          child: Image.asset("assets/Logo.png")),
                    ),
                    InputField(
                      controller: username,
                      hintText: "Username",
                      validator: (value){
                        if(value.isEmpty){
                          return "Username is required";
                        }
                        return null;
                      },
                    ),
                    InputField(
                      controller: password,
                      hintText: "Password",
                      validator: (value){
                        if(value.isEmpty){
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    state is LoadingState? const CircularProgressIndicator() : Button(
                        label: "LOGIN",
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            context.read<AuthBloc>().add(LoginEvent(username.text, password.text));
                          }
                        }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterScreen()));
                            },
                            child: const Text("REGISTER",style: TextStyle(color: Colors.blueAccent),))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}