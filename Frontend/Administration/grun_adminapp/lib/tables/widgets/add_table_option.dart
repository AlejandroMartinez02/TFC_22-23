import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/tables_provider.dart';
import 'add_table_dialog.dart';

class AddTable extends StatelessWidget {
  const AddTable({super.key});

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);

    return GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTableDialog(
                bodyLarge: bodyLarge,
                isLoading: tableProvider.isLoadingAction,
              );
            }),
        child: Container(
            color: Constants.secondaryColor,
            child: Center(
                child: Text(
              Constants.addTable,
              style: bodyLarge.copyWith(color: Colors.white),
            ))));
  }
}
