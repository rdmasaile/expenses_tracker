// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:expense_tracker/pages/login.dart';
import 'package:flutter/material.dart';
import '../helper/database_helper.dart';
import '../widgets/widgets.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  // bool isAuthenticated = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void signin() async {
    if (_formKey.currentState!.validate()) {
      int id = await DatabaseHelper.instance.addUser(User(
        fname: fnameController.text.trim(),
        lname: lnameController.text.trim(),
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      ));
      if (id > 0) {
        nextScreenReplace(context, const Login());
      } else {
        showDialogueBox(
          context,
          icon: "error",
          "Some error occured when saving your details.",
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign in",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: fnameController,
                    validator: (value) => (value!.isEmpty)
                        ? "First name must not be Empty"
                        : null,
                    decoration: inputDecoration.copyWith(
                      labelText: "First Name",
                      hintText: "Thabo",
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
                    controller: lnameController,
                    validator: (value) =>
                        (value!.isEmpty) ? "Last name must not be Empty" : null,
                    decoration: inputDecoration.copyWith(
                      labelText: "Last Name",
                      hintText: "example",
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
                    controller: usernameController,
                    validator: (value) =>
                        (value!.isEmpty) ? "Username must not be Empty" : null,
                    decoration: inputDecoration.copyWith(
                      labelText: "Username",
                      hintText: "example",
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
                    controller: passwordController,
                    validator: (value) => (value!.length < 5)
                        ? "Password must have at least 6 characters"
                        : null,
                    obscureText: true,
                    decoration: inputDecoration.copyWith(
                      labelText: "Password",
                      hintText: "",
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xffee7b64),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        signin();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
