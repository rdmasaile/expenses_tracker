import 'package:expense_tracker/components/drawer_header.dart';
import 'package:expense_tracker/components/menu_list.dart';
import 'package:expense_tracker/pages/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/components/search.dart';
import 'package:expense_tracker/helper/database_helper.dart';
// import 'package:expense_tracker/components/button.dart';
// import 'package:expense_tracker/components/table.dart';
// import 'package:expense_tracker/pages/find_transaction.dart';
import 'package:expense_tracker/widgets/widgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Transaction> transactions = [];
  @override
  void initState() {
    super.initState();
    // DatabaseHelper.instance
    //     .add(transaction(name: "Reatile", address: "84:55:33:56:21:66"));
    DatabaseHelper.instance.getTransactions().then((values) {
      if (mounted) {
        setState(() {
          transactions = values;
        });
      }
    });
  }

  Widget _buildListtransactionView() {
    List containers = [];
    if (transactions.isEmpty) {
      return Container(
        width: double.maxFinite,
        height: 200,
        decoration: const BoxDecoration(
          color: Color.fromARGB(213, 1, 5, 17),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: const Center(
            child: Text(
          "There are no transactions.",
          style: TextStyle(color: Colors.white),
        )),
      );
    }
    for (var transaction in transactions) {
      containers.add(Container(
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(213, 1, 5, 17),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListTile(
          onLongPress: () {
            showDialogueBox(
              context,
              "Do you want to delete this transaction?",
              [
                button("Cancel", () {
                  print("Canceled");
                  Navigator.of(context).pop();
                }),
                button("Yes", () {
                  print("Delete");
                  DatabaseHelper.instance.remove(transaction.id!);
                  setState(() {
                    transactions.remove(transaction);
                  });
                  Navigator.of(context).pop();
                })
              ],
            );
          },
          leading: const Icon(
            Icons.food_bank_rounded,
            color: Colors.white,
          ),
          title: Text(
            transaction.name,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "M ${transaction.amount}",
            style: const TextStyle(color: Colors.white),
          ),
          trailing: button("Find", () {
            // nextScreen(context, LoginTotransaction(transaction: transaction));
          }),
        ),
      ));
    }
    return Column(children: [...containers]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 215,
              width: double.maxFinite,
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      color: Color.fromARGB(250, 1, 2, 29),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3505A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Incomes",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${transactions.length}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3505A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Expenses",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${transactions.length}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3505A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Balance",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${transactions.length}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: const Search(),
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent transactions",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Color.fromARGB(190, 14, 3, 3),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      GlobalValues.setCurrentPage(const AddTransaction());
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            _buildListtransactionView(),
            // SingleChildScrollView(
            //   child: Tables(
            //     heading: "transactions",
            //     heads: ["Name", "Action"],
            //     rows: [
            //       [
            //         const Text("Reatile"),
            //         button("Find", () {
            //           nextScreen(context, const Findtransaction());
            //         })
            //       ],
            //       [
            //         const Text("Reatile"),
            //         button("Find", () {
            //           nextScreen(context, const Findtransaction());
            //         })
            //       ],
            //       [
            //         const Text("Reatile"),
            //         button("Find", () {
            //           nextScreen(context, const Findtransaction());
            //         })
            //       ],
            //     ],
            //     maxHeight: 300,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
