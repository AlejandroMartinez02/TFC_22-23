import 'package:flutter/material.dart';

class OrderTitle extends StatelessWidget {
  const OrderTitle({
    super.key,
    required this.index,
    required this.size,
  });

  final int index;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text("Pedido #$index",
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: size.width < 600 ? 25 : 30));
  }
}
