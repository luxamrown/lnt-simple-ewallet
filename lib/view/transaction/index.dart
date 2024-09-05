// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lnt_simple_ewallet/view/auth/login/index.dart';
import 'package:lnt_simple_ewallet/view/auth/register/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/history/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/payment/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/topup/index.dart';

class TransactionView {
  // final authService = AuthService();
  Widget renderPayment() {
    return PaymentPage();
  }

  Widget renderTopup() {
    return TopupPage();
  }

  Widget renderHistory() {
    return HistoryPage();
  }

  // Widget renderProfile() {
  //   final currentUser = authService.getCurrentUser();

  //   return FutureBuilder(future: authService.getCurrentUser(), builder: (context, snapshot) {
  //     if(!snapshot.hasData) return CircularProgressIndicator();

  //     return ProfilePage(authService: authService, currentUser: snapshot.data!);
  //   });

  // }
}
