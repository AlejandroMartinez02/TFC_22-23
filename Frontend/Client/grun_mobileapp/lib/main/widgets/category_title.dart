import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CategoryTitle extends StatelessWidget {
  const CategoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Text(Constants.categoryTitle,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: width < 600 ? 30 : 35,
            color: Colors.black,
            fontWeight: FontWeight.w500));
  }
}
