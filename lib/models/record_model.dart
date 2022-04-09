class RecordModel {
  late String userName;
  late int amount;

  RecordModel({required this.userName, required this.amount});

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'amount': amount,
    };
  }
}
