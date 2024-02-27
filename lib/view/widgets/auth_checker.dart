import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/view_model/user_view_model.dart';

import '../screens/login_screen.dart';

class AuthChecker extends StatelessWidget {
  final Widget Function(BuildContext, User?) builder;
  const AuthChecker({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && (!snapshot.data!.isAnonymous)) {
          final user = snapshot.data;
          return builder(context, user);
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
