import 'package:expense_tracker/components/dashboard.dart';
import 'package:expense_tracker/pages/login.dart';
import 'package:expense_tracker/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'components/menu_list.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(250, 1, 2, 29),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
        ),
        primarySwatch: Colors.blueGrey,
        primaryColor: Constants().primaryColor,
      ),
      home: const Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget currentPage = const Dashboard();
  @override
  void initState() {
    super.initState();
    GlobalValues.setHome(this);
  }

  void setCurrentPage(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker")),
      drawer: Drawer(
        child: Column(children: const [MenuList()]),
      ),
      body: currentPage,
    );
  }
}
