import 'package:flutter/material.dart';
import 'package:grun_mobileapp/menu/widgets/widgets.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: const [
              CategoryList(),
              ProductList(),
            ],
          ),
        ),
      ),
    ));
  }
}
