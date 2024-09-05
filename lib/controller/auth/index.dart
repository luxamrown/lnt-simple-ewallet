import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lnt_simple_ewallet/controller/firebase/index.dart';
import 'package:lnt_simple_ewallet/model/profile.dart';

class AuthService extends FirebaseService {
  final String userCollectionConst = "users";

  Future<User?> signIn(Map<String, String> userData) async {
    try {
      UserCredential credential = await fireBaseAuthInstance().signInWithEmailAndPassword(email: userData['email'] as String, password: userData['password'] as String);
      
      return credential.user;

    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUp(Profile userData) async {
    try {
      UserCredential credential = await fireBaseAuthInstance().createUserWithEmailAndPassword(email: userData.email as String, password: userData.password as String);

      if(credential.user == null) {
        throw Exception("Register Failed");
      }

      String uid = credential.user!.uid;

      DocumentReference userRef = firestoreInstance().collection(userCollectionConst).doc(uid);

      await userRef.set(userData.toMap());
      
      return credential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future updateProfile(String fullname, String telNum) async {
    final User? currentUser = fireBaseAuthInstance().currentUser;

    try {
      await firestoreInstance().collection(userCollectionConst).doc(currentUser!.uid).update({
        'fullname': fullname,
        'telNum': telNum
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUser() {
    final User user = fireBaseAuthInstance().currentUser!;
    
    try {
      return firestoreInstance().collection(userCollectionConst).doc(user.uid).snapshots();

    } catch (e) {
      rethrow;
    }

  }

  Future<void> signOut() async {
     try {
      await fireBaseAuthInstance().signOut();
     } catch (e) {
      rethrow;
     }
  }
}