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
      }, merge: true);

  Future<void> addNewExpense(String userUID, double expenseValue) => _firestore
      .collection("userFinance")
      .document(userUID)
      .collection("expenses")
      .document()
      .setData({
        'value': expenseValue,
        'timestamp': FieldValue.serverTimestamp()
      });

  Stream<QuerySnapshot> expensesList(String userUID) => _firestore
      .collection("userFinance")
      .document(userUID)
      .collection("expenses")
      .orderBy('timestamp', descending: true)
      .snapshots();

  Stream<QuerySnapshot> lastExpense(String userUID) => _firestore
      .collection("userFinance")
      .document(userUID)
      .collection("expenses")
      .orderBy('timestamp', descending: true)
      .limit(1)
      .snapshots();
}