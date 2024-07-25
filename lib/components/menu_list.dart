import 'package:expense_tracker/pages/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/components/drawer_header.dart';
import 'package:expense_tracker/widgets/widgets.dart';
// import '';
import 'dashboard.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  var currentPage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MyDrawerHeader(),
          const Divider(),
          Container(
            color: currentPage == DrawerSection.home
                ? Colors.grey[300]
                : Colors.transparent,
            child: ListTile(
              onTap: () {
                setState(() {
                  currentPage = DrawerSection.home;
                });
                GlobalValues.setCurrentPage(const Dashboard());
              },
              leading: const Icon(Icons.home),
              title: const Text("Home"),
            ),
          ),
          Container(
            color: currentPage == DrawerSection.dashboard
                ? Colors.grey[300]
                : Colors.transparent,
            child: ListTile(
              onTap: () {
                setState(() {
                  currentPage = DrawerSection.dashboard;
                });
                GlobalValues.setCurrentPage(const Dashboard());
              },
              leading: const Icon(Icons.dashboard_rounded),
              title: const Text("Dasboard"),
            ),
          ),
          Container(
            color: currentPage == DrawerSection.addDevices
                ? Colors.grey[300]
                : Colors.transparent,
            child: ListTile(
              onTap: () {
                setState(() {
                  currentPage = DrawerSection.addDevices;
                });

                GlobalValues.setCurrentPage(const AddTransaction());
              },
              leading: const Icon(Icons.app_registration_rounded),
              title: const Text("Add Transaction"),
            ),
          ),
          Container(
            color: currentPage == DrawerSection.categories
                ? Colors.grey[300]
                : Colors.transparent,
            child: ListTile(
              onTap: () {
                setState(() {
                  currentPage = DrawerSection.categories;
                });
              },
              leading: const Icon(Icons.category),
              title: const Text("Categories"),
            ),
          ),
          Container(
            color: currentPage == DrawerSection.incomes
                ? Colors.grey[300]
                : Colors.transparent,
            child: ListTile(
              onTap: () {
                setState(() {
                  currentPage = DrawerSection.incomes;
                });
              },
              leading: const Icon(Icons.list),
              title: const Text("Incomes"),
            ),
          ),
          Container(
            color: currentPage == DrawerSection.expenses
                ? Colors.grey[300]
                : Colors.transparent,
            child: ListTile(
              onTap: () {
                setState(() {
                  currentPage = DrawerSection.expenses;
                });
              },
              leading: const Icon(Icons.list),
              title: const Text("Expenses"),
            ),
          ),
        ],
      ),
    );
  }
}

enum DrawerSection {
  home,
  dashboard,
  addDevices,
  incomes,
  expenses,
  categories
}
