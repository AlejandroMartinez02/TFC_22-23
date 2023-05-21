import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../domain/entities/dish_dto.dart';
import '../ui/dish_provider.dart';
import '../../utils/widgets/update_textbox.dart';
import 'update_category.dart';

class UpdateDishDialog extends StatelessWidget {
  const UpdateDishDialog({
    super.key,
    required this.dish,
    required this.bodyLarge,
  });
  final DishDTO dish;
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
              Constants.updateDish,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, dishProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _EditDishForm(dishProvider: dishProvider, dish: dish),
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
      MaterialButton(
        onPressed: dishProvider.isLoadingAction
            ? null
            : () async {
                final response = await dishProvider.updateDish();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          dishProvider.isLoadingAction
              ? Constants.waiting
              : Constants.updateDish,
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
                message: Constants.updateDishSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateDishError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateDishError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 100:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.anyChangeDoneDish,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _EditDishForm extends StatelessWidget {
  const _EditDishForm({
    required this.dishProvider,
    required this.dish,
  });

  final DishProvider dishProvider;
  final DishDTO dish;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: dishProvider.updateDishKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
            maxLines: 1,
            hintText: Constants.nameDishHint,
            inputType: TextInputType.name,
            labelText: Constants.dishNameText,
            onChanged: (value) => dishProvider.updatedDish.name = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.nameDishError : null,
            initialValue: dish.name,
          ),
          CustomFormTextBox(
            maxLines: 3,
            hintText: Constants.descriptionDishHint,
            inputType: TextInputType.name,
            labelText: Constants.descriptionDishText,
            onChanged: (value) => dishProvider.updatedDish.description = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.descriptionDishError : null,
            initialValue: dish.description,
          ),
          CustomFormTextBox(
            maxLines: 1,
            hintText: Constants.costDishHint,
            inputType: TextInputType.number,
            labelText: Constants.costDishText,
            onChanged: (value) => dishProvider.updatedDish.cost =
                double.tryParse(value!.replaceAll(",", "")) ?? 0.0,
            validator: (value) =>
                double.tryParse(value!.replaceAll(",", "")) == 0.0
                    ? Constants.costDishError
                    : null,
            initialValue: dish.cost.toString(),
          ),
          CustomFormTextBox(
            maxLines: 3,
            hintText: Constants.ingredientsDishHint,
            inputType: TextInputType.number,
            labelText: Constants.ingredientsText,
            onChanged: (value) => dishProvider.updatedDish.ingredients = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.ingredientsDishError : null,
            initialValue: dish.ingredients.toString(),
          ),
          UpdateSelectCategory(dishProvider: dishProvider),
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
