import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lnt_simple_ewallet/firebase_options.dart';
import 'package:lnt_simple_ewallet/view/auth/index.dart';
import 'package:lnt_simple_ewallet/view/index.dart';
import 'package:lnt_simple_ewallet/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LnT E-wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: AuthView().renderLogin(),
    );
  }
}