import 'package:auto_size_text/auto_size_text.dart';
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
    return Container(
      constraints: BoxConstraints(
          minWidth: size.width * 0.2, maxWidth: size.width * 0.4),
      child: MaterialButton(
        height: size.height * 0.1,
        onPressed: () async {
          final response = await menuProvider.finishOrder();

          _checkResponse(status: response);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        textColor: Colors.white,
        color: Constants.secondaryColor,
        child: AutoSizeText(Constants.payButtonText,
            minFontSize: size.width < 600 ? 16 : 28,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyLarge),
      ),
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
