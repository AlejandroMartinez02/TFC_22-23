import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/category_dto.dart';

class ProductCategory extends StatelessWidget {
  final CategoryDTO category;
  const ProductCategory({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text("Categoría : ${category.name}",
        style: TextStyle(
            fontSize: size.width < 600 ? 24 : 30, fontFamily: 'Paralucent'));
  }
}
