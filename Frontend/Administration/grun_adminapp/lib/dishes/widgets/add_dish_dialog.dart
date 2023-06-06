import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../utils/widgets/update_textbox.dart';
import '../domain/entities/dish_dto.dart';
import '../ui/dish_provider.dart';
import 'add_category.dart';

class AddDishDialog extends StatelessWidget {
  const AddDishDialog({
    super.key,
    required this.bodyLarge,
  });
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dishProvider = Provider.of<DishProvider>(context);

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              Constants.addDish,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, dishProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _AddDishForm(
                  dishProvider: dishProvider, dish: dishProvider.newDish),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _dialogActions(BuildContext context, DishProvider dishProvider) {
    return [
      MaterialButton(
        onPressed: dishProvider.isLoadingAction
            ? null
            : () async {
                final response = await dishProvider.addDish();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          dishProvider.isLoadingAction ? Constants.waiting : Constants.addDish,
          style: bodyLarge.copyWith(
              color: dishProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.secondaryColor),
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
      ),
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 201:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addDishSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addDishError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addDishError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _AddDishForm extends StatelessWidget {
  const _AddDishForm({
    required this.dishProvider,
    required this.dish,
  });

  final DishProvider dishProvider;
  final DishDTO dish;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: dishProvider.addDishKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.nameDishHint,
            inputType: TextInputType.name,
            labelText: Constants.dishNameText,
            onChanged: (value) => dishProvider.newDish.name = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.nameDishError : null,
          ),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 3,
            hintText: Constants.descriptionDishHint,
            inputType: TextInputType.name,
            labelText: Constants.descriptionDishText,
            onChanged: (value) => dishProvider.newDish.description = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.descriptionDishError : null,
          ),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.costDishHint,
            inputType: TextInputType.number,
            labelText: Constants.costDishText,
            onChanged: (value) => dishProvider.newDish.cost =
                double.tryParse(value!.replaceAll(",", "")) ?? 0.0,
            validator: (value) =>
                double.tryParse(value!.replaceAll(",", "")) == 0.0
                    ? Constants.costDishError
                    : null,
          ),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 3,
            hintText: Constants.ingredientsDishHint,
            inputType: TextInputType.name,
            labelText: Constants.ingredientsText,
            onChanged: (value) => dishProvider.newDish.ingredients = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.ingredientsDishError : null,
          ),
          AddCategory(dishProvider: dishProvider),
          Platform.isWindows || Platform.isMacOS || Platform.isLinux
              ? Container(
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () async {
                        await dishProvider.getImage();
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.camera_alt_outlined),
                          SizedBox(
                            width: size.width * 0.01,
                          ),
                          Text(
                            Constants.changePhoto,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      )))
              : Container()
        ],
      ),
    );
  }
}
