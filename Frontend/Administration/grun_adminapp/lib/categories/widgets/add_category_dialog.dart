import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../utils/widgets/update_textbox.dart';
import '../domain/entities/category_dto.dart';
import '../ui/category_provider.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({
    super.key,
    required this.bodyLarge,
  });
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              Constants.addCategory,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, categoryProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _AddCategoryForm(
                  categoryProvider: categoryProvider,
                  category: categoryProvider.newCategory),
            ),
          ),
        ),
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
                final response = await categoryProvider.addCategory();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          categoryProvider.isLoadingAction
              ? Constants.waiting
              : Constants.addCategory,
          style: bodyLarge.copyWith(
              color: categoryProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.secondaryColor),
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
      ),
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 201:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addCategorySuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addCategoryError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.categoryCreated,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 500:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addCategoryError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _AddCategoryForm extends StatelessWidget {
  const _AddCategoryForm({
    required this.categoryProvider,
    required this.category,
  });

  final CategoryProvider categoryProvider;
  final CategoryDTO category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: categoryProvider.addCategoryKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.nameCategoryHint,
            inputType: TextInputType.name,
            labelText: Constants.nameCategoryText,
            onChanged: (value) => categoryProvider.newCategory.name = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.nameCategoryError : null,
          ),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 3,
            hintText: Constants.descriptionCategoryHint,
            inputType: TextInputType.name,
            labelText: Constants.descriptionCategoryText,
            onChanged: (value) =>
                categoryProvider.newCategory.description = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.descriptionCategoryError : null,
          ),
          Platform.isWindows || Platform.isMacOS || Platform.isLinux
              ? Container(
                  margin: EdgeInsets.only(top: size.height * 0.05),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () async {
                        await categoryProvider.getImage();
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
