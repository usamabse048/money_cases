import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_cases/models/user_model.dart';

class Database {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((e) => print("Failed to add user $e"));
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
}
