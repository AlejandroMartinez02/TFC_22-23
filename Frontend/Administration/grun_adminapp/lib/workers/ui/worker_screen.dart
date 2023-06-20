import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/utils.dart';

import '../domain/entities/worker_dto.dart';
import '../widgets/widgets.dart';
import 'worker_provider.dart';

class WorkerScreen extends StatelessWidget {
  const WorkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    if (workerProvider.isLoading) return const LoadingScreen();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          FadeInDown(
            duration: Constants.componentAnimationDuration,
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05, bottom: size.height * 0.05),
              child: _WorkerTitle(bodyLarge: bodyLarge),
            ),
          ),
          Expanded(
              child: FadeInRight(
            duration: Constants.componentAnimationDuration,
            child: WorkerDataGrid(
                workerProvider: workerProvider, bodyLarge: bodyLarge),
          )),
        ],
      ),
    );
  }
}

class WorkerDataGrid extends StatelessWidget {
  const WorkerDataGrid({
    super.key,
    required this.workerProvider,
    required this.bodyLarge,
  });

  final WorkerProvider workerProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final workerSource = WorkerDataSource(
        bodyLarge: bodyLarge, categories: workerProvider.workers);
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
            : cellTapFunction(context, details, workerSource),
        allowSwiping: true,
        columnWidthMode: ColumnWidthMode.fill,
        highlightRowOnHover: true,
        source: workerSource,
        columns: dataGridColumns,
        startSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            UpdateWorker(rowIndex: rowIndex),
        endSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            DeleteWorker(
          bodyLarge: bodyLarge,
          rowIndex: rowIndex,
        ),
        footerFrozenRowsCount: 1,
        footer: const AddWorker(),
      ),
    );
  }

  Future<dynamic> cellTapFunction(BuildContext context,
      DataGridCellTapDetails details, WorkerDataSource workerSource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowWorkerCell(
              details: details,
              bodyLarge: bodyLarge,
              workerSource: workerSource);
        });
  }

  List<GridColumn> get dataGridColumns {
    return [
      GridColumn(
          columnName: Constants.workerName,
          label: const ColumnWorkerWidget(
            columnTitle: Constants.workerName,
          )),
      GridColumn(
          columnName: Constants.workerLastname,
          label: const ColumnWorkerWidget(
            columnTitle: Constants.workerLastname,
          )),
      GridColumn(
          columnName: Constants.workerEmail,
          label: const ColumnWorkerWidget(
            columnTitle: Constants.workerEmail,
          )),
      GridColumn(
          columnName: Constants.workerPhone,
          label: const ColumnWorkerWidget(
            columnTitle: Constants.workerPhone,
          )),
      GridColumn(
          columnName: Constants.workerAge,
          label: const ColumnWorkerWidget(
            columnTitle: Constants.workerAge,
          )),
      GridColumn(
          columnName: Constants.workerMaritalStatus,
          label: const ColumnWorkerWidget(
            columnTitle: Constants.workerMaritalStatus,
          )),
      GridColumn(
          columnName: Constants.workerRole,
          label: const ColumnWorkerWidget(
            columnTitle: Constants.workerRole,
          ))
    ];
  }
}

class ShowWorkerCell extends StatelessWidget {
  const ShowWorkerCell(
      {super.key,
      required this.bodyLarge,
      required this.workerSource,
      required this.details});
  final DataGridCellDetails details;
  final TextStyle bodyLarge;
  final WorkerDataSource workerSource;

  @override
  Widget build(BuildContext context) {
    final value = workerSource
        .effectiveRows[details.rowColumnIndex.rowIndex - 1]
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

class _WorkerTitle extends StatelessWidget {
  const _WorkerTitle({
    required this.bodyLarge,
  });

  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.workerTitle,
      style: bodyLarge.copyWith(fontSize: 35),
    );
  }
}

class ColumnWorkerWidget extends StatelessWidget {
  const ColumnWorkerWidget({
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

class WorkerDataSource extends DataGridSource {
  WorkerDataSource(
      {required List<WorkerDTO> categories, required this.bodyLarge}) {
    _categories = categories
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: Constants.workerName, value: e.name),
              DataGridCell(
                  columnName: Constants.workerLastname, value: e.lastname),
              DataGridCell(columnName: Constants.workerEmail, value: e.email),
              DataGridCell(columnName: Constants.workerPhone, value: e.phone),
              DataGridCell(
                columnName: Constants.workerAge,
                value: convertToDate(DateTime.parse(e.age)).toString(),
              ),
              DataGridCell(
                  columnName: Constants.workerMaritalStatus,
                  value: e.maritalStatus),
              DataGridCell(columnName: Constants.workerRole, value: e.role),
            ]))
        .toList();
  }

  int convertToDate(DateTime date) {
    return DateTime.now().year - date.year;
  }

  final TextStyle bodyLarge;
  List<DataGridRow> _categories = [];

  @override
  List<DataGridRow> get rows => _categories;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((worker) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          worker.value,
          maxLines: 1,
          style: bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }
}
