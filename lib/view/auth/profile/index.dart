import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  // final AuthService authService;
  // final Stream<DocumentSnapshot<Map<String, dynamic>>> currentUser;

  // const ProfilePage(
  //     {Key? key, required this.currentUser})
  //     : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditMode = false;
  // void handleLogout() {
  //   widget.authService.signOut();

  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (_) => AuthPage().renderLogin()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(28),
              child: Column(
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
                  Text("Mohamad El Abror",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(Colors.grey.shade700.value)),
                      )),
                  Text("0821312312321",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(Colors.grey.shade700.value)),
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
              ))),
    );
  }
}
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//           child: Padding(
//               padding: EdgeInsets.all(28),
//               child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                 stream: widget.currentUser,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text("Error: ${snapshot.error}");
//                   } else {
//                     // final data = snapshot.data;

//                     return Column(
//                       children: [
//                         SizedBox(
//                           height: 80,
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           child: Image(
//                               image: NetworkImage(
//                                   "https://avatar.iran.liara.run/public"),
//                               width: 150),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text("data!['fullname']",
//                             textAlign: TextAlign.left,
//                             style: GoogleFonts.lato(
//                               textStyle: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w800,
//                                   color: Color(Colors.grey.shade700.value)),
//                             )),
//                         Text("data!['email']",
//                             textAlign: TextAlign.left,
//                             style: GoogleFonts.lato(
//                               textStyle: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(Colors.grey.shade700.value)),
//                             )),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         Container(
//                             width: double.maxFinite,
//                             height: 50,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "Sign Out",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red),
//                             )),
//                         // CircleAvatar(
//                         //   backgroundImage: NetworkImage("https://avatar.iran.liara.run/public"),
//                         //   minRadius: 60,
//                         // )
//                       ],
//                     );
//                   }
//                 },
//               ))),
//     );
//   }
// }