import 'package:flutter/material.dart';
import 'package:grun_adminapp/dishes/widgets/add_dish_dialog.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/dish_provider.dart';

class AddDish extends StatelessWidget {
  const AddDish({super.key});

  @override
  Widget build(BuildContext context) {
    final dishProvider = Provider.of<DishProvider>(context);
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);

    return GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              dishProvider.newDish.category = dishProvider.categories[0];
              return AddDishDialog(
                bodyLarge: bodyLarge,
                isLoading: dishProvider.isLoadingAction,
              );
            }),
        child: Container(
            color: Constants.secondaryColor,
            child: Center(
                child: Text(
              Constants.addDish,
              style: bodyLarge.copyWith(color: Colors.white),
            ))));
  }
}
