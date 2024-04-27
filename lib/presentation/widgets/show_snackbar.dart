import 'package:flutter/material.dart';

void showsnackbar(context, String e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(duration: const Duration(seconds: 1), content: Text(e)),
  );
}
