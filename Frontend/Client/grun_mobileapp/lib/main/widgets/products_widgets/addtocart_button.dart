import 'package:flutter/material.dart';
import 'package:grun_mobileapp/utils/constants.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.width * 0.6,
      height: size.height * 0.1,
      onPressed: () {},
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      textColor: Colors.white,
      color: Constants.secondaryColor,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Constants.addToCartButtonText,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: size.width < 600 ? 22 : 28,
                    )),
            Icon(
              Icons.shopping_cart,
              size: size.width < 600 ? 22 : 28,
            ),
          ]),
    );
  }
}
