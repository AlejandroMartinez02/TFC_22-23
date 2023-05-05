import 'package:flutter/material.dart';

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
        child: const Image(image: AssetImage("assets/hamburgerLoader.gif")),
      ),
    );
  }
}
