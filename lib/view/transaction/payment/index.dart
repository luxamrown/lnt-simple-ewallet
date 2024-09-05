import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnt_simple_ewallet/controller/transaction/index.dart';
import 'package:lnt_simple_ewallet/view/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/index.dart';

class PaymentPage extends StatefulWidget {
  final TransactionService transactionService;

  const PaymentPage({Key? key, required this.transactionService}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final formKeyReg = GlobalKey<FormState>();

  bool _submitLoading = false;

  String username = '';
  int amount = 0;

  void handleSubmit() async {
    late String scaffoldMessage = "";

    setState(() {
      _submitLoading = true;
    });
    
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (formKeyReg.currentState!.validate()) {
      formKeyReg.currentState!.save();
      
      try {
        await widget.transactionService.transferOut(username, amount);
        
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => IndexPage()));

        scaffoldMessage = "Transfer Success";
      }  catch (e) {
        scaffoldMessage = "Transfer Failed";
      }
    }

    if(scaffoldMessage.isNotEmpty){
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(scaffoldMessage)));
    } 
    setState(() {
      _submitLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(28),
            child: Column(children: [
              Container(
                width: double.maxFinite,
                child: Text("Transfer",
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
              Form(
                key: formKeyReg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      key: ValueKey('username'),
                      controller: _usernameController,
                      decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          labelStyle: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(Colors.grey.shade400.value)),
                          ),
                          prefixIcon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          username = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                      key: ValueKey('amount'),
                      controller: _amountController,
                      decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          labelStyle: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Color(Colors.grey.shade400.value)),
                          ),
                          prefixIcon: Icon(Icons.attach_money)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Amount is required';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        setState(() {
                          amount = int.parse(value!);
                        });
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        width: double.maxFinite,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submitLoading ? null : handleSubmit,
                          child: Text(
                            _submitLoading ? "Loading" : "Send Transfer",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                        )),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
