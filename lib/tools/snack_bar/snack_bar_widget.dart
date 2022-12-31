import 'package:flutter/material.dart';

snackBarSuccessWidget(BuildContext context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

snackBarErrorWidget(context, text) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 5,
      backgroundColor: Colors.red,
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 2000),
    ),
  );
}
