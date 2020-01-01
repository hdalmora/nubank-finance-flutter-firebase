import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String id;
  double expenseValue;
  Timestamp timestamp;

  ExpenseModel({this.id, this.expenseValue, this.timestamp});

  factory ExpenseModel.fromDocument(DocumentSnapshot document) {
    return ExpenseModel(
      id: document.documentID,
      expenseValue: document['value'],
      timestamp: document['timestamp']
    );
  }
}