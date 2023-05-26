import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../menu/ui/menu_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/services/navigator_service.dart';
import 'created_order_notification.dart';
import 'error_creating_order_notification.dart';
import 'select_table_dialog.dart';

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
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SelectTableDialog();
              });
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
}
