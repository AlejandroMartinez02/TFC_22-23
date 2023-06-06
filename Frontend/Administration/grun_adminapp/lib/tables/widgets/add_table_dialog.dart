import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../utils/widgets/update_textbox.dart';
import '../domain/entities/table_dto.dart';
import '../ui/tables_provider.dart';

class AddTableDialog extends StatelessWidget {
  const AddTableDialog({
    super.key,
    required this.isLoading,
    required this.bodyLarge,
  });
  final bool isLoading;
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
              Constants.addTable,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, tableProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _AddTableForm(
                  tableProvider: tableProvider, table: tableProvider.newTable),
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
        onPressed: isLoading
            ? null
            : () async {
                final response = await tableProvider.createTable();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          isLoading ? Constants.waiting : Constants.addTable,
          style: bodyLarge.copyWith(
              color: isLoading ? Colors.grey : Constants.secondaryColor),
        ),
      ),
      MaterialButton(
        onPressed: isLoading
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: isLoading ? Colors.grey : Constants.secondaryColor),
        ),
      ),
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 201:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addTableSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addTableError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 500:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addTableError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _AddTableForm extends StatelessWidget {
  const _AddTableForm({
    required this.tableProvider,
    required this.table,
  });

  final TableProvider tableProvider;
  final TableDTO table;

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    return Form(
      key: tableProvider.addTableKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
              initialValue: '',
              maxLines: 1,
              hintText: Constants.tableNumberHint,
              inputType: TextInputType.number,
              labelText: Constants.tableNumberText,
              onChanged: (value) => tableProvider.newTable.tableNumber =
                  int.tryParse(value!) ?? 0,
              validator: (value) {
                final number = int.tryParse(value!) ?? 0;
                return number <= 0 || tableProvider.checkExistingTables(number)
                    ? Constants.invalidNumberTable
                    : null;
              }),
        ],
      ),
    );
  }
}
