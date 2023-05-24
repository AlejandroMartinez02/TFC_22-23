import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/dish_provider.dart';

class DeleteDish extends StatelessWidget {
  const DeleteDish(
      {super.key, required this.rowIndex, required this.bodyLarge});

  final int rowIndex;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final dishProvider = Provider.of<DishProvider>(context);
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: _dialogActions(context, dishProvider),
                content: Text(
                  Constants.deleteDishTitle,
                  style: bodyLarge,
                ),
              );
            });
      },
      child: Container(
        color: Constants.redColor,
        child: const Icon(FontAwesomeIcons.trashCan, color: Colors.white),
      ),
    );
  }

  List<Widget> _dialogActions(BuildContext context, DishProvider dishProvider) {
    return [
      MaterialButton(
        onPressed: dishProvider.isLoadingAction
            ? null
            : () async {
                dishProvider.currentDishIndex = rowIndex;
                final response = await dishProvider
                    .deleteDish(dishProvider.dishes[rowIndex].id);
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          dishProvider.isLoadingAction
              ? Constants.waiting
              : Constants.deleteDish,
          style: bodyLarge.copyWith(
              color: dishProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.redColor),
        ),
      ),
      MaterialButton(
        onPressed: dishProvider.isLoadingAction
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: dishProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.secondaryColor),
        ),
      )
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 200:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteDishSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteDishError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteDishError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}
