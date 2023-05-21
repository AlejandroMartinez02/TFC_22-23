import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/dish_provider.dart';
import 'update_dish_dialog.dart';

class UpdateDish extends StatelessWidget {
  const UpdateDish({super.key, required this.rowIndex});

  final int rowIndex;

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
            dishProvider.updatedDish =
                (dishProvider.dishes[rowIndex]).copyWith();
            dishProvider.currentDishIndex = rowIndex;
            return UpdateDishDialog(
              dish: dishProvider.dishes[rowIndex],
              bodyLarge: bodyLarge,
            );
          }),
      child: Container(
        color: Constants.blueColor,
        child: const Icon(
          FontAwesomeIcons.penToSquare,
          color: Colors.white,
        ),
      ),
    );
  }
}
