import 'package:flutter/material.dart';

import '../../utils/widgets/card/card_widgets.dart';
import '../domain/entity/category_dto.dart';

class CategoryCard extends StatelessWidget {
  final CategoryDTO category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.9,
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            BackgroundImage(photo: category.photo),
            const BackgroundColor(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(category.name,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: size.width < 600 ? 30 : 34,
                              )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    child: Text(
                      category.description,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: size.width < 600 ? 18 : 20,
                          ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
