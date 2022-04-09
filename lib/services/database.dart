import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_cases/models/transaction_model.dart';
import 'package:money_cases/models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserToDb(
      {required String name,
      required String uid,
      required String email,
      required String phoneNumber}) async {
    Map<String, dynamic> moneyMap = await getAllUserMap();

    UserModel user = UserModel(
        uid: uid,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        money: moneyMap);

    await _firestore
        .collection("users")
        .doc(uid)
        .set(user.toMap())
        .then((value) => print("User Added"))
        .catchError((e) => print("Failed to add user $e"));

    await addNewUserToExistingUsersMoneyMap(uid, name);
  }

  Future<void> addNewUserToExistingUsersMoneyMap(
      String uid, String name) async {
    await _firestore.collection("users").get().then((QuerySnapshot value) {
      value.docs.forEach((element) async {
        Map<String, dynamic> existingMoneyMap = element["money"];
        existingMoneyMap[name] = 0;
        await _firestore
            .collection("users")
            .doc(element["uid"])
            .update({"money": existingMoneyMap});
      });
    });
  }

  Future<Map<String, dynamic>> getAllUserMap() async {
    Map<String, dynamic> moneyMap = {};

    await _firestore.collection("users").get().then((QuerySnapshot value) {
      value.docs.forEach((element) {
        moneyMap[element["name"]] = 0;
      });
    }).catchError((e) => print(e));
    return moneyMap;
  }

  Future<void> addTransactionToDb({
    required String title,
    required double amount,
    required DateTime time,
    required String creator,
    required List partners,
    required String creatorId,
    required List<dynamic> partnerIds,
  }) async {
    var docId = _firestore.collection("transactions").doc().id;
    TransactionModel transactionModel = TransactionModel(
        id: docId,
        title: title,
        parteners: partners,
        amount: amount,
        creator: creator,
        creatorId: creatorId,
        partnerIds: partnerIds,
        time: time);

    await _firestore
        .collection("transactions")
        .doc(docId)
        .set(transactionModel.toMap());

    await updateMoneyMap(transactionModel);
  }

  //update users money map

  Future<void> updateMoneyMap(TransactionModel transaction) async {
    UserModel user = await _firestore
        .collection('users')
        .doc(transaction.creatorId)
        .get()
        .then((value) {
      return UserModel.fromDocumentSnapshot(value);
    });

    for (var i in transaction.parteners) {
      user.money[i] = user.money[i] +
          transaction.amount / (transaction.parteners.length + 1);
    }

    await _firestore
        .collection('users')
        .doc(transaction.creatorId)
        .set(user.toMap());

    // transaction.partnerIds.forEach((i) async {
    //   UserModel partnerModel =
    //       await _firestore.collection('users').doc(i).get().then((value) {
    //     return UserModel.fromDocumentSnapshot(value);
    //   });

    //   print("print model id: ${partnerModel.uid}");
    // });

    for (String i in transaction.partnerIds) {
      UserModel partnerModel =
          await _firestore.collection('users').doc(i).get().then((value) {
        return UserModel.fromDocumentSnapshot(value);
      });
      // partnerModel.printMoneyMap();
      partnerModel.money[transaction.creator] =
          partnerModel.money[transaction.creator] -
              transaction.amount / (transaction.parteners.length + 1);

      await _firestore.collection('users').doc(i).set(partnerModel.toMap());
    }
  }
}
