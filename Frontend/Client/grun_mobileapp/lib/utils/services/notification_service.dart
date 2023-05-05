import 'package:flutter/material.dart';
import 'package:grun_mobileapp/utils/constants.dart';

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

  static showSnackBarOnMain(String message) {
    final snackbar = SnackBar(
        backgroundColor: Constants.secondaryColor,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ));

    messengerKey.currentState!.showSnackBar(snackbar);
  }
}
