import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_cases/constants/controllers.dart';
import 'package:money_cases/constants/global_constant.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);
  static String route = "/transactionScreen";

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _amountTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  List partners = List.empty(growable: true);
  List partnerIds = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _titleTextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter title";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amountTextEditingController,
                  decoration: InputDecoration(
                      hintText: "Amount",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an amount";
                    } else if (!RegExp("^[+]?\d+([.]\d+)?\$").hasMatch(value)) {
                      return "Please enter a valid amount";
                    } else {
                      _amountTextEditingController.text = value;
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Text(
                  "Select Partners",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  padding: EdgeInsets.all(12.0),
                  width: MediaQuery.of(context).size.width,
                  height: 300.0,
                  //color: Colors.red,
                  child: Obx(() {
                    return SingleChildScrollView(
                      child: Column(
                        children: List<Widget>.generate(
                            userController.allUsers.length,
                            (index) => PartnersSelector(index: index)),
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                  child: ElevatedButton(
                    child: const Text("Add Transaction"),
                    onPressed: () {
                      if (transactionController.partners.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Bhosari walay partner tou select kar!!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ));
                      } else if (_formKey.currentState!.validate()) {
                        transactionController.addTransactionToDb(
                            title: _titleTextEditingController.text,
                            amount:
                                double.parse(_amountTextEditingController.text),
                            time: DateTime.now(),
                            creator: GlobalConstant.currentUser.name,
                            partners: transactionController.partners,
                            creatorId: GlobalConstant.currentUser.uid,
                            partnerIds: transactionController.partnerIds);
                      } else {}

                      //TODO:: empty the partner lists from transaction controller and pop screen
                      transactionController.partners.forEach((element) {
                        print(element);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    transactionController.partnerIds.clear();
    transactionController.partners.clear();
    super.dispose();
  }
}

class PartnersSelector extends StatefulWidget {
  const PartnersSelector({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<PartnersSelector> createState() => _PartnersSelectorState();
}

class _PartnersSelectorState extends State<PartnersSelector> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(userController.allUsers[widget.index].name),
        Checkbox(
            value: value,
            onChanged: (mybool) {
              setState(() {
                value = mybool!;
              });

              if (value) {
                transactionController.partners
                    .add(userController.allUsers[widget.index].name);
                transactionController.partnerIds
                    .add(userController.allUsers[widget.index].uid);
              } else {
                transactionController.partners
                    .remove(userController.allUsers[widget.index].name);

                transactionController.partnerIds
                    .remove(userController.allUsers[widget.index].uid);
              }
            })
      ]),
    );
  }
}
