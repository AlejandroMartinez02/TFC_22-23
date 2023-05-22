import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/category_provider.dart';

class DeleteCategory extends StatelessWidget {
  const DeleteCategory(
      {super.key, required this.rowIndex, required this.bodyLarge});

  final int rowIndex;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: _dialogActions(context, categoryProvider),
                content: Text(
                  Constants.deleteCategory,
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

  List<Widget> _dialogActions(
      BuildContext context, CategoryProvider categoryProvider) {
    return [
      MaterialButton(
        onPressed: categoryProvider.isLoadingAction
            ? null
            : () async {
                categoryProvider.currentCategoryIndex = rowIndex;
                final response = await categoryProvider.deleteCategory(
                    categoryProvider.categories[rowIndex].id,
                    categoryProvider.categories[rowIndex].photo);
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          categoryProvider.isLoadingAction
              ? Constants.waiting
              : Constants.deleteCategory,
          style: bodyLarge.copyWith(
              color: categoryProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.redColor),
        ),
      ),
      MaterialButton(
        onPressed: categoryProvider.isLoadingAction
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: categoryProvider.isLoadingAction
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
                message: Constants.deleteCategorySuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteCategoryError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteCategoryError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}
