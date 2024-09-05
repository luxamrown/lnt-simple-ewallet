// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lnt_simple_ewallet/controller/transaction/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/history/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/payment/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/topup/index.dart';

class TransactionView {
  final transactionService = TransactionService();
  Widget renderPayment() {
    return PaymentPage(transactionService: transactionService);
  }

  Widget renderTopup() {
    return TopupPage(transactionService: transactionService);
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
