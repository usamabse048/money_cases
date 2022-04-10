import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cases/constants/controllers.dart';
import 'package:money_cases/models/transaction_model.dart';
import 'package:money_cases/screens/add_transaction_screen.dart';
import 'package:money_cases/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  static String route = "/homescreen";
  const HomeScreen({Key? key}) : super(key: key);

  // late final uid;
  // Future getUser() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   setState(() {
  //     uid = sharedPreferences.get("uid");
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getUser().whenComplete(() async {
  //     if (uid == null) {
  //       navigator?.pushNamed(LoginScreen.route);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, TransactionScreen.route);
        },
      ),
      appBar: AppBar(
        title: const Text(
          "Home Screen",
        ),
      ),
      body: Obx(() {
        return Column(
          children: List<Widget>.generate(
            transactionController.transactionHistory.length,
            (index) => TransactionContainer(
              transaction: transactionController.transactionHistory[index],
            ),
          ),
        );
      }),
    );
  }
}

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({Key? key, required this.transaction})
      : super(key: key);
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 114,
            color: const Color(0xFF40445a),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        transaction.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "RS. ${transaction.amount.toString()}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Card(
                  color: const Color(0xFF323949),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
                    child: Text(transaction.creator),
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Text(
                  transaction.time.toString(),
                  style: const TextStyle(fontSize: 8),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 1.0,
          color: Colors.white,
        )
      ],
    );
  }
}
