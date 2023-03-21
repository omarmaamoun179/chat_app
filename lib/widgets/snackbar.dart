import 'package:flutter/material.dart';

void snackBar(BuildContext context, String Message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(Message)),
    );
  }