import 'package:flutter/material.dart';
import 'package:grun_mobileapp/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../menu/ui/menu_provider.dart';
import '../../../utils/services/navigator_service.dart';
import 'created_order_notification.dart';
import 'error_creating_order_notification.dart';

class PayButton extends StatelessWidget {
  const PayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final size = MediaQuery.of(context).size;
    return MaterialButton(
      minWidth: size.width * 0.6,
      height: size.height * 0.1,
      onPressed: () async {
        final response = await menuProvider.finishOrder();

        _checkResponse(status: response);
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      textColor: Colors.white,
      color: Constants.secondaryColor,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Constants.payButtonText,
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

  void _checkResponse({required int status}) {
    switch (status) {
      case 200:
        _showDialog(child: const CreatedOrderNotification());
        break;
      case 500:
        _showDialog(child: const ErrorCreatingOrderNotification());
    }
  }

  void _showDialog({required Widget child}) {
    showDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (context) {
          return child;
        });
  }
}
