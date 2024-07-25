import 'package:flutter/material.dart';
import '../helper/database_helper.dart';
import '../widgets/widgets.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<Transaction> searchedTransactions = [];
  bool searching = false;

  Widget _buildListTransactionView(BuildContext context) {
    List containers = [];
    if (searchedTransactions.isEmpty) {
      return Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 41),
        height: 60,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 252, 252, 252),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: const Center(
            child: Text(
          "No Transactions found.",
          style: TextStyle(color: Colors.black),
        )),
      );
    }
    for (var transaction in searchedTransactions) {
      print(transaction.toString());
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
              "Do you want to delete this Transaction?",
              [
                button("Cancel", () {
                  print("Canceled");
                  Navigator.of(context).pop();
                }),
                button("Yes", () {
                  print("Delete");
                  DatabaseHelper.instance.remove(transaction.id!);
                  setState(() {
                    searchedTransactions.remove(transaction);
                  });
                  Navigator.of(context).pop();
                })
              ],
            );
          },
          leading: const Icon(
            Icons.key_sharp,
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
            // nextScreen(context, LoginToTransaction(Transaction: Transaction));
          }),
        ),
      ));
    }
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 41),
        // height: 200,
        color: Colors.white,
        child: Column(children: [...containers]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: searchController,
          onTapOutside: (event) {
            Future.delayed(const Duration(milliseconds: 500)).then((value) {
              if (mounted) {
                setState(() {
                  searching = false;
                  searchedTransactions = [];
                  searchController.clear();
                  searchController.clearComposing();
                });
              }
            });
          },
          onChanged: (value) async {
            searching = true;
            await DatabaseHelper.instance
                .getTransactionsWhere(value)
                .then((value) {
              setState(() {
                searchedTransactions = value;
              });
            });
            if (value.isEmpty) {
              setState(() {
                searchedTransactions = [];
              });
            }
          },
          style: const TextStyle(fontSize: 20),
          decoration: inputDecoration.copyWith(
            labelText: "Search",
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        (searching) ? _buildListTransactionView(context) : const Text(""),
      ],
    );
  }
}
