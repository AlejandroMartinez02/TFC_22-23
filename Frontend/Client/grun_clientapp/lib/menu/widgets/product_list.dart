import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/menu_provider.dart';
import 'widgets.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final actualProducts = menuProvider.categories.isEmpty
        ? []
        : menuProvider.categoryProducts[
            menuProvider.categories[menuProvider.actualCategory].name];
    final size = MediaQuery.of(context).size;

    if (menuProvider.isLoading) return const PageLoading();
    return actualProducts!.isEmpty
        ? NoProducts(size: size)
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: actualProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCard(product: actualProducts[index]);
            },
          );
  }
}
