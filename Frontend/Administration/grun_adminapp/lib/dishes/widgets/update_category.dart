import 'package:flutter/material.dart';

import '../ui/dish_provider.dart';

class UpdateSelectCategory extends StatelessWidget {
  const UpdateSelectCategory({
    super.key,
    required this.dishProvider,
  });

  final DishProvider dishProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      child: DropdownButton(
          isExpanded: true,
          value: dishProvider.updatedDish.category.name,
          onChanged: (value) =>
              dishProvider.changeCategory(value, dishProvider.updatedDish),
          items: dishProvider.categories
              .map((e) => DropdownMenuItem(
                  value: e.name,
                  child: Text(
                    e.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  )))
              .toList()),
    );
  }
}
