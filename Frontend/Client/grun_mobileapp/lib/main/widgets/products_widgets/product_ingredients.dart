import 'package:flutter/material.dart';

class ProductIngredients extends StatelessWidget {
  final String ingredients;
  const ProductIngredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Divider(
          thickness: 2,
          color: Colors.white,
        ),
        SizedBox(
          height: size.height * 0.01,
        ),
        Text("Ingredientes",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: size.width < 600 ? 24 : 30,
                )),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(ingredients,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: size.width < 600 ? 22 : 28, color: Colors.grey)),
      ],
    );
  }
}
