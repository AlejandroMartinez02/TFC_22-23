import 'package:flutter/material.dart';
import 'package:grun_mobileapp/screens/screens.dart';
import 'package:grun_mobileapp/services/services.dart';
import 'package:grun_mobileapp/widgets/main_widgets/main_widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 237, 237),
        appBar: AppBar(
          title: const Text("Productos"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextTitle(),
              ),
              GestureDetector(
                child: ProductSwiper(products: productService.products),
              ),
              ProductSlider(products: productService.products),
            ],
          ),
        ));
  }
}
