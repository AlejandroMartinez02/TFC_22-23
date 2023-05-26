import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../data/network/response/products_dto.dart';
import '../widgets/products_widgets/product_bottom_bar.dart';
import '../widgets/products_widgets/product_category.dart';
import '../widgets/products_widgets/product_description.dart';
import '../widgets/products_widgets/product_image.dart';
import '../widgets/products_widgets/product_title.dart';

class ProductScreen extends StatelessWidget {
  final ProductDTO product;
  const ProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.8),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProductImage(photo: product.photo, id: product.id),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.height * 0.02),
            child: Column(children: [
              FadeInRightBig(
                  duration: Constants.componentAnimationDuration,
                  child: Column(
                    children: [
                      Container(
                          constraints: BoxConstraints(
                              maxHeight: 50, maxWidth: size.width),
                          child: ProductTitle(name: product.name)),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      ProductCategory(category: product.category),
                      const Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      ProductIngredients(ingredients: product.ingredients),
                    ],
                  )),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: ProductBottomBar(cost: product.cost),
    );
  }
}
