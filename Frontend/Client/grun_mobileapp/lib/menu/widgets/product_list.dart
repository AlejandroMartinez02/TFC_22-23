import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grun_mobileapp/menu/widgets/widgets.dart';
import 'package:grun_mobileapp/menu/ui/menu_provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final actualProducts = menuProvider.categoryProducts[
        menuProvider.categories[menuProvider.actualCategory].name];
    final size = MediaQuery.of(context).size;

    if (menuProvider.isLoading) return LoadingProductWidget(size: size);
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
