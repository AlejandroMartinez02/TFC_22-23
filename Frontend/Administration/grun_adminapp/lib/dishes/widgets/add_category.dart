import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../ui/dish_provider.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({
    super.key,
    required this.dishProvider,
  });

  final DishProvider dishProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyLarge =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            Constants.selectCategory,
            style: bodyLarge,
          ),
          value: dishProvider.newDish.category.name,
          onChanged: (value) =>
              dishProvider.changeCategory(value, dishProvider.newDish),
          items: dishProvider.categories
              .map((e) => DropdownMenuItem(
                  value: e.name,
                  child: Text(
                    e.name,
                    style: bodyLarge,
                  )))
              .toList()),
    );
  }
}
