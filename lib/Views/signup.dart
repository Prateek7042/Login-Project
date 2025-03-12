import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../AuthBloc/auth_bloc.dart';
import '../Constants/env.dart';
import '../Models/users.dart';
import '../components/button.dart';
import '../components/textfield.dart';
import 'home.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is SuccessRegister){
          Env.gotoReplacement(context, const Home());
        }else if (state is FailureState){
          //If there is an error show the message
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

                    ListTile(
                      horizontalTitleGap: 5,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      leading: Hero(
                          tag: "image",
                          child: Image.asset("assets/Logo.png")),
                      title: const Text("REGISTER"),
                      subtitle: const Text("Create new user"),
                    ),
                    InputField(
                      controller: fullName,
                      hintText: "Full name",
                      validator: (value){
                        if(value.isEmpty){
                          return "Full name is required";
                        }
                        return null;
                      },
                    ),
                    InputField(
                      controller: email,
                      hintText: "Email",
                      validator: (value){
                        if(value.isEmpty){
                          return "Email is required";
                        }
                        return null;
                      },
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
                    InputField(
                      controller: confirmPassword,
                      hintText: "Re-enter password",
                      validator: (value){
                        if(value.isEmpty){
                          return "Re-enter password is required";
                        }else if (password.text != confirmPassword.text){
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                    state is LoadingState? const CircularProgressIndicator() : Button(
                        label: "REGISTER",
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            context.read<AuthBloc>().add(RegisterEvent(
                                Users(
                                    fullName: fullName.text,
                                    email: email.text,
                                    username: username.text,
                                    password: password.text
                                )));
                          }
                        }
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
                            },
                            child: const Text("LOGIN",style: TextStyle(color: Colors.blueAccent),))
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