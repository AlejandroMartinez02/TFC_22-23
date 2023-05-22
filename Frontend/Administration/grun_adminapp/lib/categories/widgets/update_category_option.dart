import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/category_provider.dart';
import 'update_category_dialog.dart';

class UpdateCategory extends StatelessWidget {
  const UpdateCategory({super.key, required this.rowIndex});

  final int rowIndex;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            categoryProvider.updatedCategory =
                (categoryProvider.categories[rowIndex]).copyWith();
            categoryProvider.currentCategoryIndex = rowIndex;
            return UpdateCategoryDialog(
              category: categoryProvider.categories[rowIndex],
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
