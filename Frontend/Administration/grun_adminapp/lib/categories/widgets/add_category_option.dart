import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'add_category_dialog.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({super.key});

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
              return AddCategoryDialog(
                bodyLarge: bodyLarge,
              );
            }),
        child: Container(
            color: Constants.secondaryColor,
            child: Center(
                child: Text(
              Constants.addCategory,
              style: bodyLarge.copyWith(color: Colors.white),
            ))));
  }
}
