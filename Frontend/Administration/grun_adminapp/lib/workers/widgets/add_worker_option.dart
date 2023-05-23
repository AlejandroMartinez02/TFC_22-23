import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'add_worker_dialog.dart';

class AddWorker extends StatelessWidget {
  const AddWorker({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);

    return GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddWorkerDialog(
                bodyLarge: bodyLarge,
              );
            }),
        child: Container(
            color: Constants.secondaryColor,
            child: Center(
                child: Text(
              Constants.addWorker,
              style: bodyLarge.copyWith(color: Colors.white),
            ))));
  }
}
