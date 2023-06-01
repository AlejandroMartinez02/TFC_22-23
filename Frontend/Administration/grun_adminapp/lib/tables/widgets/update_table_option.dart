import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/tables_provider.dart';
import 'update_table_dialog.dart';

class UpdateTable extends StatelessWidget {
  const UpdateTable({super.key, required this.rowIndex});

  final int rowIndex;

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
            tableProvider.updatedTable =
                (tableProvider.tables[rowIndex]).copyWith();
            tableProvider.currentTableIndex = rowIndex;
            return UpdateTableDialog(
              table: tableProvider.tables[rowIndex],
              bodyLarge: bodyLarge,
            );
          }),
      child: Container(
        color: Constants.blueColor,
        child: const Icon(
          FontAwesomeIcons.penToSquare,
          color: Colors.white,
        ),
      ),
    );
  }
}
