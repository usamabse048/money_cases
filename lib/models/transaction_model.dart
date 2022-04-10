import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  late String id;
  late String title;
  late String creatorId;
  DateTime time = DateTime.now();
  late double amount;
  late String creator;
  late List parteners;
  late List partnerIds;

  TransactionModel(
      {required this.id,
      required this.title,
      required this.parteners,
      required this.creator,
      required this.creatorId,
      required this.partnerIds,
      required this.amount,
      required this.time});

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        id: map['id'],
        title: map['title'],
        parteners: map['parteners'],
        time: map['time'],
        creator: map['creator'],
        creatorId: map['creatorId'],
        partnerIds: map['partnerIds'],
        amount: map['amount']);
  }

  factory TransactionModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
    return TransactionModel(
        id: queryDocumentSnapshot.data()['id'] ?? "",
        title: queryDocumentSnapshot.data()['title'] ?? "",
        parteners: queryDocumentSnapshot.data()['parteners'] ?? [],
        creator: queryDocumentSnapshot.data()['creator'] ?? "",
        creatorId: queryDocumentSnapshot.data()['creatorId'] ?? "",
        partnerIds: queryDocumentSnapshot.data()["partnerIds"] ?? [],
        amount: queryDocumentSnapshot.data()["amount"] ?? 0,
        time: (queryDocumentSnapshot.data()['time'] as Timestamp).toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'partners': parteners,
      'amount': amount,
      'creator': creator
    };
  }
}
