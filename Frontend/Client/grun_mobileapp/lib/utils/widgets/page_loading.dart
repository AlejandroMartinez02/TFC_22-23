import 'package:flutter/material.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
        child: const Image(image: AssetImage("assets/hamburgerLoader.gif")),
      ),
    );
  }
}
