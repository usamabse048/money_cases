import 'package:get/get.dart';
import 'package:money_cases/models/transaction_model.dart';
import 'package:money_cases/services/database.dart';

class TransactionController extends GetxController {
  static TransactionController instance = Get.find();
  final Database _database = Database();
  List partners = List.empty(growable: true);
  List partnerIds = List.empty(growable: true);

  RxList<TransactionModel> transactionHistory = RxList<TransactionModel>();

  void addTransactionToDb(
      {required String title,
      required double amount,
      required DateTime time,
      required String creator,
      required List partners,
      required String creatorId,
      required List<dynamic> partnerIds}) {
    _database.addTransactionToDb(
        title: title,
        amount: amount,
        time: time,
        creator: creator,
        partners: partners,
        creatorId: creatorId,
        partnerIds: partnerIds);
  }

  @override
  void onInit() {
    transactionHistory.bindStream(_database.getTransactionHistory());
    super.onInit();
  }
}
