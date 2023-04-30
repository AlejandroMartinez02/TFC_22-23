import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String message) {
    final snackbar = SnackBar(
        content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ));

    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
