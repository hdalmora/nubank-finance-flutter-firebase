import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreResources {
  Firestore _firestore = Firestore.instance;

  Stream<DocumentSnapshot> userFinanceDoc(String userUID) => _firestore
      .collection("userFinance")
      .document(userUID)
      .snapshots();

  Future<void> setUserBudget(String userUID, double budget) => _firestore
      .collection("userFinance")
      .document(userUID)
      .setData({
        'budget': budget
      });
}