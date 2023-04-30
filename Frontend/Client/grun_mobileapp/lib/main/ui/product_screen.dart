import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/products_dto.dart';

class ProductScreen extends StatelessWidget {
  final ProductDTO product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Container(color: Colors.red),
    );
  }
}
