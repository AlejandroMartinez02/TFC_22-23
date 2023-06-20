import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../ui/menu_provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      children: [
        Platform.isLinux || Platform.isIOS || Platform.isWindows
            ? const CustomAppBar()
            : Container(),
        menuProvider.categories.isEmpty
            ? const SizedBox()
            : Container(
                height: size.height * 0.1,
                width: size.width,
                color: primaryColor,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ScrollablePositionedList.separated(
                    itemScrollController: menuProvider.categoryController,
                    scrollDirection: Axis.horizontal,
                    itemCount: menuProvider.categories.length,
                    initialScrollIndex: menuProvider.actualCategory,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          menuProvider.changeActualPage(page: index);
                          menuProvider.categoryController.scrollTo(
                              alignment: 0.5,
                              index: index,
                              duration: const Duration(milliseconds: 200));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: menuProvider.actualCategory == index
                                  ? Constants.secondaryColor
                                  : primaryColor),
                          child: Center(
                            child: AutoSizeText(
                              menuProvider.categories[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: size.width < 600 ? 22 : 24,
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6)),
                  ),
                ),
              )
      ],
    );
  }
}
