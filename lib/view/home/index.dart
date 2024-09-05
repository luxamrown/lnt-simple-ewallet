import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnt_simple_ewallet/controller/auth/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/index.dart';

class HomePage extends StatefulWidget {
  final AuthService authService = AuthService();

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _balanceVisible = false;

  late Stream<DocumentSnapshot<Map<String, dynamic>>> _profileStream;

  @override
  void initState() {
    super.initState();
    _profileStream = widget.authService.getCurrentUser();
  }

  handleClickTopup(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionView().renderTopup()));
  }

  handleClickPayment(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionView().renderPayment()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(children: [
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: _profileStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (!snapshot.data!.exists) {
                      return Text("User not Found",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(Colors.grey.shade700.value)),
                          ));
                    } else {
                      final data = snapshot.data;

                      return Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: double.maxFinite,
                            child: Text("Hello, ${data!['fullname']}",
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text("LnT Pay Account - ${data!['username']}",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(
                                                  Colors.grey.shade800.value)),
                                        )),
                                    Divider(
                                      thickness: 0.2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            _balanceVisible
                                                ? "Rp ${data!['balance']}"
                                                : "Rp **********",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(Colors
                                                      .grey.shade800.value)),
                                            )),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _balanceVisible =
                                                  !_balanceVisible;
                                            });
                                          },
                                          child: Icon(
                                              _balanceVisible
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined,
                                              color: Colors.grey.shade800),
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(0),
                                            backgroundColor:
                                                Colors.grey.shade200,
                                            shadowColor: Colors.transparent,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade300,
                                            shadowColor: Colors.transparent,
                                          ),
                                          onPressed: () {
                                            handleClickPayment(context);
                                          },
                                          icon: Icon(Icons.attach_money,
                                              color: Colors.grey.shade100),
                                          label: Text("Pay",
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(Colors
                                                        .grey.shade100.value)),
                                              )),
                                        ),
                                        const SizedBox(width: 10),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade300,
                                            shadowColor: Colors.transparent,
                                          ),
                                          onPressed: () {
                                            handleClickTopup(context);
                                          },
                                          icon: Icon(Icons.add,
                                              color: Colors.grey.shade100),
                                          label: Text("Top Up",
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(Colors
                                                        .grey.shade100.value)),
                                              )),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                          )
                        ],
                      );
                    }
                  })
            ])),
      ),
    );
  }
}
