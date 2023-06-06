import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../exports/providers.dart';
import '../../menu/widgets/no_products.dart';
import '../widgets/main_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    final mainProvider = Provider.of<MainProvider>(context);

    final size = MediaQuery.of(context).size;
    return mainProvider.products.isEmpty || mainProvider.categories.isEmpty
        ? Scaffold(body: SafeArea(child: NoProducts(size: size)))
        : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(children: [
              const BackgroundMainTitle(),
              Column(
                children: [
                  SizedBox(
                    height: size.height < 600
                        ? size.height * 0.02
                        : size.height * 0.04,
                  ),
                  const TextTitle(),
                  ProductSwiper(products: mainProvider.lessPaidProducts),
                  const MenuDivider(),
                  const CategoryTitle(),
                  const MenuDivider(),
                  SizedBox(
                    height: size.height < 600
                        ? size.height * 0.1
                        : size.height * 0.03,
                  ),
                  ...mainProvider.categories.asMap().entries.map((e) =>
                      GestureDetector(
                          onTap: () => mainProvider.changeActualPage(
                              1, menuProvider,
                              secondaryPageName: e.key),
                          child: CategoryCard(category: e.value)))
                ],
              ),
            ]),
          );
  }
}

class MenuDivider extends StatelessWidget {
  const MenuDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 30,
      thickness: 2,
    );
  }
}
