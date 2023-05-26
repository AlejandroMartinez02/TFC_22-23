import 'package:flutter/material.dart';

class ProductIngredients extends StatelessWidget {
  final String ingredients;
  const ProductIngredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(ingredients,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: size.width < 600 ? 22 : 28, color: Colors.grey));
  }
}
