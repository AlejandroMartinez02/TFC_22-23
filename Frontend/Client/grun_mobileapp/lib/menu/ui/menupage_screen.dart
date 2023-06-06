import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: const SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              CategoryList(),
              ProductList(),
            ],
          ),
        ),
      ),
    ));
  }
}
