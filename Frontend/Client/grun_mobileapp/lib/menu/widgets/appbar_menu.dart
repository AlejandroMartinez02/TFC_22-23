import 'package:flutter/material.dart';
import 'package:grun_mobileapp/menu/widgets/category_list.dart';

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      actions: [CategoryList()],
    );
  }
}
