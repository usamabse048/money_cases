import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String uid;
  late String name;
  late String phoneNumber;
  late String email;
  late Map<String, dynamic> money;

  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.money,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'],
        name: map['name'],
        phoneNumber: map['phoneNumber'],
        email: map['email'],
        money: map['money']);
  }

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
        uid: snapshot.data()?['uid'] ?? "",
        name: snapshot.data()?['name'] ?? "",
        phoneNumber: snapshot.data()?['phoneNumber'] ?? "",
        email: snapshot.data()?['email'] ?? "",
        money: snapshot.data()?['money'] ?? {});
  }

  factory UserModel.fromQueryDocumentSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
        uid: snapshot.data()['uid'] ?? "",
        name: snapshot.data()['name'] ?? "",
        phoneNumber: snapshot.data()['phoneNumber'] ?? "",
        email: snapshot.data()['email'] ?? "",
        money: snapshot.data()['money'] ?? {});
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'money': money,
    };
  }

  // void printMoneyMap() {
  //   money.forEach((key, value) {
  //     print("$key :: $value");
  //   });
  // }
}
