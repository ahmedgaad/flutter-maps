import 'package:flutter/material.dart';

void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.white.withOpacity(0.0),
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

Widget divider() {
  return const Divider(
    // color: Colors.black,
    indent: 18.0,
    endIndent: 24.0,
    height: 0,
    thickness: 1,
  );
}
