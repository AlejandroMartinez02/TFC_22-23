import 'package:flutter/material.dart';

import '../constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Image(
        image: Constants.burgerLoader,
      ),
    ));
  }
}
