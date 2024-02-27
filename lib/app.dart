import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/view/screens/home_screen.dart';
import 'package:todoapp/view/screens/login_screen.dart';
import 'package:todoapp/view/widgets/auth_checker.dart';
import 'package:todoapp/view_model/user_view_model.dart';
import 'package:todoapp/view_model/task_view_model.dart';


class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel()),
        ChangeNotifierProxyProvider<UserViewModel, TaskViewModel>(
            create: (context) => TaskViewModel(owner: ""),
            update: (context, userViewModel, taskViewModel) => TaskViewModel(owner: userViewModel.currentUserId)
        )
      ],
      child: MaterialApp(
        title: 'TodoA App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //initialRoute: HomeScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          HomeScreen.routeName: (context) =>  AuthChecker(builder: (context, user) {
            return const HomeScreen();
          }),
        },
      ),
    );
  }
}