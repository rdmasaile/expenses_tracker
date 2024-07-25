// ignore_for_file: use_build_context_synchronously

import 'package:expense_tracker/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helper/database_helper.dart';
import '../widgets/widgets.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  var type = TransactionType.income;
  @override
  void initState() {
    super.initState();
  }

  void addTransaction() async {
    if (_formKey.currentState!.validate()) {
      int id = await DatabaseHelper.instance.add(Transaction(
          name: nameController.text.trim(),
          amount: double.parse(amountController.text),
          type: type == TransactionType.income ? "income" : "expense"));
      if (id > 0) {
        nameController.clear();
        amountController.clear();
        showDialogueBox(context, icon: "success", "Successfully saved.", [
          button("OK", () {
            popContext(context);
          })
        ]);
      } else {
        showDialogueBox(
          context,
          icon: "error",
          "Some error occured when saving the transaction.",
          [
            button("OK", () {
              Navigator.of(context).pop();
            })
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Transaction",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) => (value!.isEmpty)
                      ? "Transaction name must not be Empty"
                      : null,
                  decoration: inputDecoration.copyWith(
                    labelText: "Transaction Name",
                    hintText: "Rent",
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xffee7b64),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: amountController,
                  validator: (value) => (value!.isEmpty)
                      ? "A transaction should not have a zero balance"
                      : null,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration.copyWith(
                    prefixText: "M",
                    labelText: "Amount",
                    hintText: "500.00",
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color(0xffee7b64),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Transaction Type"),
                Row(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Radio(
                              value: TransactionType.income,
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  type = value!;
                                });
                              }),
                          const Text("Income")
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          Radio(
                              value: TransactionType.expense,
                              groupValue: type,
                              onChanged: (value) {
                                setState(() {
                                  type = value!;
                                });
                              }),
                          const Text("Expense")
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      addTransaction();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum TransactionType { income, expense }
