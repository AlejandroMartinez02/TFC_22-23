import 'package:flutter/material.dart';

import '../constants.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black, fontSize: size.width < 600 ? 20 : 24),
          ),
        ),
        const Image(
          image: Constants.notFoundImage,
        )
      ],
    );
  }
}
