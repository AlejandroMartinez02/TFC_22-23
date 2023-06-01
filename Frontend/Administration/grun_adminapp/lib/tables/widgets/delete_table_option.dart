import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/tables_provider.dart';

class DeleteTable extends StatelessWidget {
  const DeleteTable(
      {super.key, required this.rowIndex, required this.bodyLarge});

  final int rowIndex;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: _dialogActions(context, tableProvider),
                content: Text(
                  Constants.deleteTableTitle,
                  style: bodyLarge,
                ),
              );
            });
      },
      child: Container(
        color: Constants.redColor,
        child: const Icon(FontAwesomeIcons.trashCan, color: Colors.white),
      ),
    );
  }

  List<Widget> _dialogActions(
      BuildContext context, TableProvider tableProvider) {
    return [
      MaterialButton(
        onPressed: tableProvider.isLoadingAction
            ? null
            : () async {
                tableProvider.currentTableIndex = rowIndex;
                final response = await tableProvider
                    .deleteTable(tableProvider.tables[rowIndex].id);
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          tableProvider.isLoadingAction
              ? Constants.waiting
              : Constants.deleteTable,
          style: bodyLarge.copyWith(
              color: tableProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.redColor),
        ),
      ),
      MaterialButton(
        onPressed: tableProvider.isLoadingAction
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: tableProvider.isLoadingAction
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
                message: Constants.deleteTableSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteTableError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 500:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteTableError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}
