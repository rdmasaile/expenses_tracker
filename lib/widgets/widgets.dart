import 'package:flutter/material.dart';

var inputDecoration = InputDecoration(
  fillColor: Colors.white,
  labelStyle: const TextStyle(color: Colors.black),
  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
  border: OutlineInputBorder(
    borderSide: const BorderSide(width: 5),
    borderRadius: BorderRadius.circular(60),
  ),
);
Widget button(String buttonName, Function action) {
  return ElevatedButton(
      onPressed: () {
        action();
      },
      child: Text(buttonName));
}

void nextScreen(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void nextScreenReplace(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void showSnackBar(BuildContext context, String message, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    // backgroundColor: color,
    action:
        SnackBarAction(label: "OK", textColor: Colors.white, onPressed: () {}),
  ));
}

void popContext(context) {
  Navigator.of(context).pop();
}

void showDialogueBox(BuildContext context, String message, actions, {icon}) {
  dynamic icons = icon;
  if (icon is String) {
    switch (icon) {
      case "error":
        icons = const Icon(
          Icons.cancel,
          size: 30,
          color: Color.fromARGB(255, 245, 42, 52),
        );
        break;
      case "success":
        icons = const Icon(
          Icons.task_alt_rounded,
          size: 30,
          color: Color.fromARGB(255, 12, 243, 127),
        );
        break;
    }
  }
  if (icons != null) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          icon: icons,
          alignment: Alignment.center,
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: actions,
        );
      },
    );
  } else {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: actions,
        );
      },
    );
  }
}

class GlobalValues {
  static dynamic home;

  static void setHome(home1) {
    home = home1;
  }

  static void setCurrentPage(page) {
    home.setCurrentPage(page);
  }
}
