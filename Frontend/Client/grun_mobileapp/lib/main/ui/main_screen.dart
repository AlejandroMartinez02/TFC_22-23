import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/screens.dart';
import 'package:grun_mobileapp/main/ui/main_provider.dart';
import 'package:grun_mobileapp/main/widgets/app_bar.dart';
import 'package:grun_mobileapp/main/widgets/main_widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final size = MediaQuery.of(context).size;

    if (mainProvider.isLoading) return const LoadingScreen();

    return Scaffold(
        backgroundColor: Color.fromARGB(237, 255, 255, 255),
        drawerEnableOpenDragGesture: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(),
              SizedBox(
                height:
                    size.height > 500 ? size.height * 0.05 : size.height * 0.02,
              ),
              const TextTitle(),
              GestureDetector(
                child: ProductSwiper(products: mainProvider.products),
              ),
              ...mainProvider.categories.map((e) => CategoryCard(category: e))
            ],
          ),
        ));
  }
}
