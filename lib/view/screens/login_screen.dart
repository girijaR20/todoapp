import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/view/screens/home_screen.dart';
import 'package:todoapp/view_model/user_view_model.dart';

class LoginScreen extends StatelessWidget {

  static const routeName = "/auth";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return FlutterLogin(
        title: "ToDo App",
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        loginAfterSignUp: false,
        validateUserImmediately: true,
        disableCustomPageTransformer: true,
        onLogin: (loginData) async {
          User? user = await userViewModel.login(loginData.name, loginData.password);
          if (user != null) {
            print(user);
            return null;
          }
          return "User not found.";
        },
        onRecoverPassword: (name) {
          return null;
        },
        onSignup: (signUpData) async {
          User? user = await userViewModel.register(signUpData.name.toString(), signUpData.password.toString());
          if (user != null) {
            print(user);
            return null;
          }
          return "Oops, Please try again.";
        },
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
        },
        theme: LoginTheme(
            titleStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white
            ),
        )
    );
  }
}

