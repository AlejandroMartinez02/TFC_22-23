import 'package:flutter/material.dart';

import '../../domain/entity/category_dto.dart';

class ProductCategory extends StatelessWidget {
  final CategoryDTO category;
  const ProductCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text("Categoría : ${category.name}",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: size.width < 600 ? 24 : 30,
            ));
  }
}
