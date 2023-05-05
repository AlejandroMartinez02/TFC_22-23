import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/providers.dart';
import 'package:grun_mobileapp/exports/screens.dart';
import 'package:grun_mobileapp/menu/ui/menu_provider.dart';
import 'package:grun_mobileapp/menu/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Scaffold(
            body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: const [
              CategoryList(),
              ProductList(),
            ],
          ),
        )),
      ),
    );
  }
}
