import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lnt_simple_ewallet/controller/firebase/index.dart';
class TransactionService extends FirebaseService {
  final String userCollectionConst = "users";
  final String transactionCollectionConst = "transaction";
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future topupBalance(int amount) async {
    final User? currentUser = fireBaseAuthInstance().currentUser;
    late int currentBalance;
    var transactionCollection = FirebaseFirestore.instance.collection(transactionCollectionConst);

    firestoreInstance().collection(userCollectionConst).doc(currentUser?.uid).get().then((document) {
      currentBalance = document['balance'];

      currentBalance = currentBalance + amount;

      try {
        firestoreInstance().collection(userCollectionConst).doc(currentUser?.uid).update({'balance': currentBalance});

        try {
          transactionCollection.add({
            'type': 'topup',
            'from': currentUser?.uid,
            'to': currentUser?.uid,
            'amount': amount,
            'timestamp': date,
          });
          
          return currentBalance;
        } catch (e) {
          rethrow;
      }
      } catch (e) {
        rethrow;
      }
    });
  }

  Future transferOut(String destinationUsername, int amount) async {
    late bool tfSuccess;
    final User? currentUser = fireBaseAuthInstance().currentUser;
    late int currentUserBalance;
    late int currentDestinationUserBalance;
    late QueryDocumentSnapshot<Map<String, dynamic>> userDestination;

    await firestoreInstance().collection(userCollectionConst).doc(currentUser?.uid).get().then((currentUserDoc) async {
      currentUserBalance = currentUserDoc['balance'];
    
      if(currentUserBalance < amount) {
        tfSuccess = false;
      } else {
        await firestoreInstance().collection(userCollectionConst).where("username", isEqualTo: destinationUsername).get().then((document) async {
          if(document.size > 0) {
            userDestination = document.docs[0];
            currentDestinationUserBalance = userDestination['balance'];
            
            currentUserBalance = currentUserBalance - amount;
            currentDestinationUserBalance = currentDestinationUserBalance + amount;

            try {
              firestoreInstance().collection(userCollectionConst).doc(currentUser?.uid).update({'balance': currentUserBalance});
              
              firestoreInstance().collection(userCollectionConst).doc(userDestination.id).update({'balance': currentDestinationUserBalance});

              var transactionCollection = FirebaseFirestore.instance.collection(transactionCollectionConst);
              
              await transactionCollection.add({
                'type': 'transfer',
                'from': currentUser?.uid,
                'to': userDestination.id,
                'amount': amount,
                'timestamp': date,
              }).then((onValue) {
                tfSuccess = true;
              });
            } catch (e) {
              rethrow;
            } 
          } else {
            throw Error();
          }
        });
      }
    });

    if(tfSuccess) {
      return true;
    } else {
      throw Error();
    }
  }
}