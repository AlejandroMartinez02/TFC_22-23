import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/order_provider.dart';

class DeleteOrderDialog extends StatelessWidget {
  const DeleteOrderDialog(
      {super.key, required this.rowIndex, required this.bodyLarge});

  final int rowIndex;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return AlertDialog(
      actions: _dialogActions(context, orderProvider),
      content: Text(
        Constants.deleteOrderTitle,
        style: bodyLarge,
      ),
    );
  }

  List<Widget> _dialogActions(
      BuildContext context, OrderProvider orderProvider) {
    return [
      MaterialButton(
        onPressed: orderProvider.isLoadingAction
            ? null
            : () async {
                orderProvider.currentOrderIndex = rowIndex;
                final response = await orderProvider
                    .deleteOrder(orderProvider.orders[rowIndex].id);
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          orderProvider.isLoadingAction
              ? Constants.waiting
              : Constants.deleteOrder,
          style: bodyLarge.copyWith(
              color: orderProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.redColor),
        ),
      ),
      MaterialButton(
        onPressed: orderProvider.isLoadingAction
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: orderProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.secondaryColor),
        ),
      )
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 200:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteOrderSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteOrderError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteOrderError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}
