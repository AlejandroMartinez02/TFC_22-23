import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class CustomOrderBottomBar extends StatelessWidget {
  const CustomOrderBottomBar(
      {super.key, required this.cost, required this.state});

  final double cost;
  final String state;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
        color: mainColor,
        height: size.height * 0.1,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: size.width < 600 ? 28 : 32,
                  color: Constants.pickColor(state)),
            ),
            Text(
              '${Constants.total} $cost€',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: size.width < 600 ? 28 : 32),
            ),
          ],
        ));
  }
}
