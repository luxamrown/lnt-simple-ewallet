import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  // final AuthService authService;

  // const HistoryPage({Key? key, required this.authService}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(children: [
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.maxFinite,
                child: Text("Transaction History (still wip)",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(Colors.blue.value)),
                    )),
              ),
              SizedBox(
                height: 40,
              ),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
              CardTransactionHistory(),
            ])),
      ),
    );
  }
}

class CardTransactionHistory extends StatelessWidget {
  const CardTransactionHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      shadowColor: Colors.transparent,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text("Transfer In",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(Colors.grey.shade800.value)),
                      )),
                  Spacer(),
                  Text("01-08-2024",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(Colors.grey.shade700.value)),
                      )),
                ],
              ),
              Row(
                children: [
                  Text("+ Rp 25.000,-",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(Colors.blue.shade400.value)),
                      )),
                  Spacer(),
                  Text("From: Fender",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Color(Colors.grey.shade700.value)),
                      )),
                ],
              )
            ],
          )),
    );
  }
}
