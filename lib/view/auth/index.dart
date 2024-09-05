// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lnt_simple_ewallet/controller/auth/index.dart';
import 'package:lnt_simple_ewallet/view/auth/login/index.dart';
import 'package:lnt_simple_ewallet/view/auth/profile/index.dart';
import 'package:lnt_simple_ewallet/view/auth/register/index.dart';

class AuthView {
  final authService = AuthService();
  Widget renderLogin() {
    return LoginPage(authService: authService);
  }

  Widget renderRegister() {
    return RegisterPage(authService: authService);
  }

  Widget renderProfile() {
    return ProfilePage(authService: authService);
  }
}