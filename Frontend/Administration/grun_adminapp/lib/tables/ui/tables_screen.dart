import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/utils.dart';
import '../domain/entities/table_dto.dart';
import '../widgets/widgets.dart';
import 'tables_provider.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TableProvider>(context);
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    if (tableProvider.isLoading) return const LoadingScreen();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          FadeInDown(
            duration: Constants.componentAnimationDuration,
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05, bottom: size.height * 0.05),
              child: _TableTitle(bodyLarge: bodyLarge),
            ),
          ),
          Expanded(
              child: FadeInRight(
            duration: Constants.componentAnimationDuration,
            child: TableDataGrid(
                tableProvider: tableProvider, bodyLarge: bodyLarge),
          )),
        ],
      ),
    );
  }
}

class TableDataGrid extends StatelessWidget {
  const TableDataGrid({
    super.key,
    required this.tableProvider,
    required this.bodyLarge,
  });

  final TableProvider tableProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final tableSource =
        TablesDataSource(bodyLarge: bodyLarge, tables: tableProvider.tables);
    final size = MediaQuery.of(context).size;

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SfDataGrid(
        onQueryRowHeight: (details) =>
            details.rowIndex == 0 ? size.height * 0.07 : size.height * 0.13,
        verticalScrollPhysics: const ClampingScrollPhysics(),
        horizontalScrollPhysics: const ClampingScrollPhysics(),
        onCellTap: (details) => details.rowColumnIndex.rowIndex - 1 < 0
            ? null
            : cellTapFunction(context, details, tableSource),
        allowSorting: true,
        allowSwiping: true,
        columnWidthMode: ColumnWidthMode.fill,
        highlightRowOnHover: true,
        source: tableSource,
        columns: dataGridColumns,
        startSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            UpdateTable(rowIndex: rowIndex),
        endSwipeActionsBuilder: (context, dataGridRow, rowIndex) => DeleteTable(
          bodyLarge: bodyLarge,
          rowIndex: rowIndex,
        ),
        footerFrozenRowsCount: 1,
        footer: const AddTable(),
      ),
    );
  }

  Future<dynamic> cellTapFunction(BuildContext context,
      DataGridCellTapDetails details, TablesDataSource tableSource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowTableCell(
              details: details, bodyLarge: bodyLarge, tableSource: tableSource);
        });
  }

  List<GridColumn> get dataGridColumns {
    return [
      GridColumn(
          columnName: Constants.tableNumberText,
          label: const ColumnTableWidget(
            columnTitle: Constants.tableNumberText,
          )),
      GridColumn(
          columnName: Constants.isInUseText,
          label: const ColumnTableWidget(
            columnTitle: Constants.isInUseText,
          )),
    ];
  }
}

class ShowTableCell extends StatelessWidget {
  const ShowTableCell(
      {super.key,
      required this.bodyLarge,
      required this.tableSource,
      required this.details});
  final DataGridCellDetails details;
  final TextStyle bodyLarge;
  final TablesDataSource tableSource;

  @override
  Widget build(BuildContext context) {
    final value = tableSource.effectiveRows[details.rowColumnIndex.rowIndex - 1]
        .getCells()[details.rowColumnIndex.columnIndex]
        .value;
    return AlertDialog(
        content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(details.column.columnName, style: bodyLarge),
        Container(
          height: 1,
          color: Colors.grey,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        Text(
          value.toString(),
          textAlign: TextAlign.center,
          style: bodyLarge,
        ),
      ],
    ));
  }
}

class _TableTitle extends StatelessWidget {
  const _TableTitle({
    required this.bodyLarge,
  });

  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.tableTitle,
      style: bodyLarge.copyWith(fontSize: 35),
    );
  }
}

class ColumnTableWidget extends StatelessWidget {
  const ColumnTableWidget({
    super.key,
    required this.columnTitle,
  });

  final String columnTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(columnTitle),
    );
  }
}

class TablesDataSource extends DataGridSource {
  TablesDataSource({required List<TableDTO> tables, required this.bodyLarge}) {
    _tables = tables
        .map((e) => DataGridRow(cells: [
              DataGridCell(
                  columnName: Constants.tableNumberText,
                  value: e.tableNumber.toString()),
              DataGridCell(
                  columnName: Constants.isInUseText,
                  value: e.isInUse ? 'Si' : 'No'),
            ]))
        .toList();
  }

  final TextStyle bodyLarge;
  List<DataGridRow> _tables = [];

  @override
  List<DataGridRow> get rows => _tables;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((table) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          table.value,
          maxLines: 1,
          style: bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }
}
