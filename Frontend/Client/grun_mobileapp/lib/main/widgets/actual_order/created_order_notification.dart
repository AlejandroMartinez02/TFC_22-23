import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/screens.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/create_route.dart';

class CreatedOrderNotification extends StatelessWidget {
  const CreatedOrderNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      title: Text(
        Constants.createdOrder,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.black),
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
                .copyWith(color: Colors.red),
          ),
        )
      ],
    );
  }
}
