import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/screens.dart';
import 'package:grun_mobileapp/main/ui/main_provider.dart';
import 'package:grun_mobileapp/main/widgets/main_widgets.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final size = MediaQuery.of(context).size;

    if (mainProvider.isLoading) return const LoadingScreen();

    return Scaffold(
        backgroundColor: const Color.fromARGB(237, 255, 255, 255),
        drawerEnableOpenDragGesture: false,
        bottomNavigationBar: const CustomBottomBar(),
        body: SingleChildScrollView(
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
                GestureDetector(
                  child: ProductSwiper(products: mainProvider.products),
                ),
                const MenuDivider(),
                const CategoryTitle(),
                const MenuDivider(),
                SizedBox(
                  height: size.height < 600
                      ? size.height * 0.1
                      : size.height * 0.03,
                ),
                ...mainProvider.categories.map((e) => CategoryCard(category: e))
              ],
            ),
          ]),
        ));
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
