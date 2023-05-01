import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/category_dto.dart';
import 'package:grun_mobileapp/utils/widgets/card/card_widgets.dart';

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
                  Text(
                    category.name,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Paralucent',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    category.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Paralucent',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
