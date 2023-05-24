import 'package:flutter/material.dart';

import '../../utils/constants.dart';

// ignore: must_be_immutable
class OrderFooter extends StatelessWidget {
  OrderFooter({super.key, required this.totalCost});

  double totalCost;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.secondaryColor,
      child: Center(
        child: Text('${Constants.totalCost}: ${totalCost.toStringAsFixed(2)}€',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
