import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage("assets/hamburgerLoader.gif"),
                  ),
                ])));
  }
}
