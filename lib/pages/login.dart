// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/pages/signup.dart';
import 'package:flutter/material.dart';
import '../helper/database_helper.dart';
import '../widgets/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // bool isAuthenticated = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void login() async {
    if (await DatabaseHelper.instance.auth(
      usernameController.text.trim(),
      passwordController.text.trim(),
    )) {
      nextScreen(context, const MyHomePage());
    } else {
      showDialogueBox(context, icon: "error", "Invalid username or password!", [
        button("OK", () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Signin()));
        })
      ]);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Log in",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: usernameController,
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
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Do you have an account?",
                      children: [
                        TextSpan(
                          text: "Sign in",
                          onEnter: (event) {
                            nextScreen(context, const Signin());
                          },
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
