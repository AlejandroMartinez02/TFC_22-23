import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:grun_mobileapp/menu/ui/menu_provider.dart';
import 'package:grun_mobileapp/utils/constants.dart';
import 'package:provider/provider.dart';

class CategoryListCard extends StatelessWidget {
  const CategoryListCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        menuProvider.changeActualPage(page: index);
        menuProvider.categoryController.scrollTo(
            index: index, duration: const Duration(milliseconds: 200));
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(Constants.borderRadius)),
            border: Border.all(color: primaryColor),
            color: menuProvider.actualCategory == index
                ? Constants.secondaryColor
                : primaryColor),
        child: Center(
          child: AutoSizeText(
            menuProvider.categories[index].name,
            style: _textStyle(size),
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle(Size size) => TextStyle(
      fontFamily: 'Paralucent',
      fontSize: size.width < 600 ? 22 : 30,
      fontWeight: FontWeight.w600);
}
