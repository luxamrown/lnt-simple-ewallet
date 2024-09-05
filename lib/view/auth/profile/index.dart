import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnt_simple_ewallet/controller/auth/index.dart';
import 'package:lnt_simple_ewallet/view/auth/index.dart';

class ProfilePage extends StatefulWidget {
  final AuthService authService;

  const ProfilePage(
      {Key? key, required this.authService})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _fullnameController = TextEditingController();
  late TextEditingController _telNumController = TextEditingController();
  
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _profileStream;

  bool _submitLoading = false;
  bool _isEditMode = false;

  String initFullname = '';
  String initTelNum = '';


  String fullname = '';
  String telNum = '';
  
  @override
  void initState() {
    super.initState();
    _profileStream = widget.authService.getCurrentUser();
    streamListener();
  }

  void streamListener() {
    _profileStream.listen((onData) async {

      setState(() {
        fullname = onData!['fullname'];
        telNum = onData!['telNum'];

        initFullname = onData!['fullname'];
        initTelNum = onData!['telNum'];

        _fullnameController = TextEditingController(text: onData!['fullname']);
        _telNumController = TextEditingController(text: onData!['telNum']);
      });
    });
  }

  void handleCancel() {
    setState(() {
      _isEditMode = !_isEditMode;

      _fullnameController = TextEditingController(text: initFullname);
      _telNumController = TextEditingController(text: initTelNum);
    });
  }

  final formKeyReg = GlobalKey<FormState>();

  void handleLogout() {
    widget.authService.signOut();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => AuthView().renderLogin()));
  }

   void handleSubmit() async {
    late String scaffoldMessage = "";

    setState(() {
      _submitLoading = true;
    });
    
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    if (formKeyReg.currentState!.validate()) {
      formKeyReg.currentState!.save();
      
      try {
        print("AHLOO ${fullname} ${telNum}");
        await widget.authService.updateProfile(fullname, telNum);
        
        setState(() {
          _isEditMode = false;
        });
        scaffoldMessage = "Update Profile Success";
      }  catch (e) {
        scaffoldMessage = "Update Profile Failed";
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
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(28),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: _profileStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    final data = snapshot.data;

                    return Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Image(
                              image: NetworkImage(
                                  "https://avatar.iran.liara.run/public"),
                              width: 150),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _isEditMode
                            ? Form(
                                key: formKeyReg,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      key: ValueKey('fullname'),
                                      controller: _fullnameController,
                                      decoration: InputDecoration(
                                          labelText: 'Fullname',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          labelStyle: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Color(Colors
                                                    .grey.shade400.value)),
                                          ),
                                          prefixIcon: Icon(Icons.person)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Fullname is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          fullname = value!;
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
                                      key: ValueKey('telNum'),
                                      controller: _telNumController,
                                      decoration: InputDecoration(
                                          labelText: 'Telephone Number',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28),
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          labelStyle: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Color(Colors
                                                    .grey.shade400.value)),
                                          ),
                                          prefixIcon: Icon(Icons.attach_money)),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Telephone is required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          telNum = value!;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                          onPressed: handleCancel,
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade400,
                                            shadowColor: Colors.transparent,
                                          ),
                                        )),
                                        Expanded(
                                            child: ElevatedButton(
                                          onPressed: _submitLoading ? null : handleSubmit,
                                          child: Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shadowColor: Colors.transparent,
                                          ),
                                        )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Text(data!['fullname'],
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Color(
                                                Colors.grey.shade700.value)),
                                      )),
                                  Text(data!['telNum'],
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(
                                                Colors.grey.shade700.value)),
                                      )),
                                ],
                              ),
                        SizedBox(
                          height: 40,
                        ),
                        if (!_isEditMode)
                          Container(
                              width: double.maxFinite,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditMode = !_isEditMode;
                                  });
                                },
                                child: Text(
                                  "Edit Profile",
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade300,
                                  shadowColor: Colors.transparent,
                                ),
                              )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            width: double.maxFinite,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: handleLogout,
                              child: Text(
                                "Sign Out",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shadowColor: Colors.transparent,
                              ),
                            )),
                      ],
                    );
                  }
                },
              ))),
    );
  }
}
