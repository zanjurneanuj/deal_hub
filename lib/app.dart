import 'package:flutter/material.dart';
import 'core/utils/session_manager.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/deals/screens/deal_list_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    final loggedIn = await SessionManager.isLoggedIn();
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DealHub',

      home: isLoggedIn!
          ? const DealListScreen() //  skip login
          : const LoginScreen(),
    );
  }
}