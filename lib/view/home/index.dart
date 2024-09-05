import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnt_simple_ewallet/view/transaction/index.dart';

class HomePage extends StatefulWidget {
  // final AuthService authService;

  // const HomePage({Key? key, required this.authService}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _balanceVisible = false;

  handleClickTopup (BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionView().renderTopup()));
  }

  handleClickPayment (BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionView().renderPayment()));
  }

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
                child: Text("Hello, {Full Name}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(Colors.blue.value)),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.grey.shade100,
                shadowColor: Colors.transparent,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("LnT Pay Account - luxamrown",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(Colors.grey.shade800.value)),
                            )),
                        Divider(
                          thickness: 0.2,
                        ),
                        Row(
                          children: [
                            Text(_balanceVisible ? "Rp 200.000" : "Rp **********",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(Colors.grey.shade800.value)),
                                )),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _balanceVisible = !_balanceVisible;
                                });
                              },
                              child: Icon(
                                  _balanceVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.grey.shade800),
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(0),
                                backgroundColor: Colors.grey.shade200,
                                shadowColor: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade300,
                                  shadowColor: Colors.transparent,
                                  ),
                                onPressed: () {
                                  handleClickPayment(context);
                                },
                                icon: Icon(Icons.attach_money, color: Colors.grey.shade100),
                                label: Text("Pay",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(Colors.grey.shade100.value)),
                                )),
                            ),

                            const SizedBox(width: 10),

                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade300,
                                  shadowColor: Colors.transparent,
                                  ),
                                onPressed: () {
                                  handleClickTopup(context);
                                },
                                icon: Icon(Icons.add, color: Colors.grey.shade100),
                                label: Text("Top Up",
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(Colors.grey.shade100.value)),
                                )),
                            )
                          ],
                        )
                      ],
                    )),
              )
            ])),
      ),
    );
  }
}
