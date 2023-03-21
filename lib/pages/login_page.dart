import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:scholar_chat/bloc/auth_bloc/auth_bloc.dart';
import 'package:scholar_chat/chat_cubit/cubit/chat_cubit.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_page.dart';
import 'package:scholar_chat/widgets/custom_button.dart';
import 'package:scholar_chat/widgets/custom_textfied.dart';

import '../widgets/snackbar.dart';

class LoginPage extends StatelessWidget {
  String? password, email;
  static String id = 'Login page';
  GlobalKey<FormState> formKey = GlobalKey();

  bool? isloading = false;
  bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          isloading = false;
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } else if (state is LoginFailed) {
          isloading = false;
          snackBar(context, state.errorMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isloading!,
        child: Scaffold(
          backgroundColor: Color(0xff314F6A),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scolar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    icon: Icon(Icons.mail),
                    message: 'please write a crrocet email',
                    onChanged: (data) {
                      email = data;
                    },
                    hinText: 'Email',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormFieldpassword(
                    message: 'incorrect password',
                    onChanged: (data) {
                      password = data;
                    },
                    hinText: 'password',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(email: email!, password: password!));
                      }
                    },
                    text: 'LOGIN',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\`t have an accout',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          ' Register Now',
                          style: TextStyle(color: Colors.blue[300]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
