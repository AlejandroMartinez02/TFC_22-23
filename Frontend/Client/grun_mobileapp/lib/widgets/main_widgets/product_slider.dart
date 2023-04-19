import 'package:flutter/material.dart';
import 'package:grun_mobileapp/models/Response/products_dto.dart';
import 'package:grun_mobileapp/widgets/main_widgets/main_widgets.dart';

class ProductSlider extends StatelessWidget {
  const ProductSlider({super.key, required this.products});
  final List<ProductDTO> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            "Categorías",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: CategoryCard(category: products[index]),
                );
              }),
        )
      ]),
    );
  }
}
