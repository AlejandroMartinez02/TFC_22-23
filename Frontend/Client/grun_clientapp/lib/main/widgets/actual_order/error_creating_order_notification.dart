import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ErrorCreatingOrderNotification extends StatelessWidget {
  const ErrorCreatingOrderNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      title: Text(
        Constants.errorCreatedOrder,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Constants.secondaryColor),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            Constants.accept,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Constants.secondaryColor),
          ),
        )
      ],
    );
  }
}
