import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoginDialog({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: SizedBox(
                height: 40, child: Center(child: CircularProgressIndicator())),
          );
        });
  }

  static void showMsgDialog(
      {required BuildContext context,
      required String msg,
      required void Function() onTap}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 23),
            ),
            actions: [TextButton(onPressed: onTap, child: const Text("Ok"))],
          );
        });
  }

  static void showConfirmDialog(
      {required BuildContext context,
      required String msg,
      required void Function() negativeonTap,
      required void Function() positiveonTap}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            content: Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 23),
            ),
            actions: [
              TextButton(onPressed: positiveonTap, child: const Text("Yes")),
              TextButton(onPressed: negativeonTap, child: const Text("No"))
            ],
          );
        });
  }
}
