import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(
        message,
      ),
    ),
  );
}
