import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../utils/widgets/update_textbox.dart';
import '../domain/entities/table_dto.dart';
import '../ui/tables_provider.dart';

class UpdateTableDialog extends StatelessWidget {
  const UpdateTableDialog({
    super.key,
    required this.table,
    required this.bodyLarge,
  });
  final TableDTO table;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tableProvider = Provider.of<TableProvider>(context);
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              Constants.updateTableTitle,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, tableProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _EditTableForm(tableProvider: tableProvider, table: table),
            ),
          ),
        ),
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
                final response = await tableProvider.updateTable();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          tableProvider.isLoadingAction
              ? Constants.waiting
              : Constants.updateTable,
          style: bodyLarge.copyWith(
              color: tableProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.secondaryColor),
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
      ),
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 200:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateTableSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateTableError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateTableError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 100:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.anyChangeDoneTable,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _EditTableForm extends StatelessWidget {
  const _EditTableForm({
    required this.tableProvider,
    required this.table,
  });

  final TableProvider tableProvider;
  final TableDTO table;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: tableProvider.updateTableKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
            maxLines: 1,
            hintText: Constants.tableNumberHint,
            inputType: TextInputType.number,
            labelText: Constants.tableNumberText,
            onChanged: (value) => tableProvider.updatedTable.tableNumber =
                int.tryParse(value!) ?? 0,
            validator: (value) {
              final number = int.tryParse(value!) ?? 0;
              return number < 0 || tableProvider.checkExistingTables(number)
                  ? Constants.invalidNumberTable
                  : null;
            },
            initialValue: table.tableNumber.toString(),
          )
        ],
      ),
    );
  }
}
