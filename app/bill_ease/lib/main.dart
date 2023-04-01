import 'package:bill_ease/app/app.dart';
import 'package:bill_ease/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = const Scaffold();

  @override
  void initState() {
    switchHome();
    super.initState();
  }

  void switchHome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? session = sharedPreferences.getString("session");
    if (session == null) {
      setState(() {
        home = const Login();
      });
    } else {
      setState(() {
        home = const App();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KJ App',
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
