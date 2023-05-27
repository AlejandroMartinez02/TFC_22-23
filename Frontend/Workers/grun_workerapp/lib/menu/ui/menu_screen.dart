import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/category_list.dart';
import '../widgets/floating_button.dart';
import '../widgets/product_list.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const CategoryList(),
          backgroundColor: Theme.of(context).primaryColor,
          toolbarHeight: size.height * 0.13,
          titleSpacing: 0.0,
        ),
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: const SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  ProductList(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: const CustomFloatingButton());
  }
}
