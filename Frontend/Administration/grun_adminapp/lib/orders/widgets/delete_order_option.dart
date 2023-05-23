import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constants.dart';
import 'delete_order_dialog.dart';

// ignore: must_be_immutable
class DeleteOrderOption extends StatelessWidget {
  DeleteOrderOption(
      {super.key, required this.bodyLarge, required this.rowIndex});

  TextStyle bodyLarge;
  int rowIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DeleteOrderDialog(
                bodyLarge: bodyLarge,
                rowIndex: rowIndex,
              );
            });
      },
      child: Container(
        color: Constants.redColor,
        child: const Icon(FontAwesomeIcons.trashCan, color: Colors.white),
      ),
    );
  }
}
