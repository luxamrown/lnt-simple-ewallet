import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuthService = FirebaseAuth.instance;
  final FirebaseFirestore _fireStoreInstance = FirebaseFirestore.instance;

  FirebaseAuth fireBaseAuthInstance() {
    return _firebaseAuthService;
  }

  FirebaseFirestore firestoreInstance() {
    return _fireStoreInstance;
  }
}