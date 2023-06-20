import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/constants.dart';
import '../domain/entities/order_dto.dart';
import '../domain/entities/order_line_dto.dart';

// ignore: must_be_immutable
class VisualizeOrderDialog extends StatelessWidget {
  VisualizeOrderDialog(
      {super.key, required this.bodyLarge, required this.order});

  TextStyle bodyLarge;
  OrderDTO order;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: AlertDialog(
        title: Text(
          Constants.orderSummary,
          style: bodyLarge.copyWith(color: Colors.black),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              Constants.accept,
              style: bodyLarge.copyWith(color: Constants.secondaryColor),
            ),
          ),
        ],
        content: OrderLinesDataGrid(
          bodyLarge: bodyLarge,
          order: order,
        ),
      ),
    );
  }
}

class OrderLinesDataGrid extends StatelessWidget {
  const OrderLinesDataGrid({
    super.key,
    required this.order,
    required this.bodyLarge,
  });

  final OrderDTO order;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final orderSource =
        OrderDataSource(bodyLarge: bodyLarge, orderLines: order.orderLines);
    final size = MediaQuery.of(context).size;
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SizedBox(
        height: size.height * 0.6,
        width: size.width * 0.6,
        child: SfDataGrid(
          onQueryRowHeight: (details) =>
              details.rowIndex == 0 ? size.height * 0.07 : size.height * 0.13,
          verticalScrollPhysics: const ClampingScrollPhysics(),
          horizontalScrollPhysics: const ClampingScrollPhysics(),
          onCellTap: (details) => details.rowColumnIndex.rowIndex - 1 < 0
              ? null
              : cellTapFunction(context, details, orderSource),
          columnWidthMode: ColumnWidthMode.fill,
          highlightRowOnHover: true,
          source: orderSource,
          columns: dataGridColumns,
        ),
      ),
    );
  }

  Future<dynamic> cellTapFunction(BuildContext context,
      DataGridCellTapDetails details, OrderDataSource orderSource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowOrderLineCell(
              details: details, bodyLarge: bodyLarge, orderSource: orderSource);
        });
  }

  List<GridColumn> get dataGridColumns {
    return [
      GridColumn(
          columnName: Constants.orderLineName,
          label: const ColumnOrderLineWidget(
            columnTitle: Constants.orderLineName,
          )),
      GridColumn(
          columnName: Constants.orderLineCount,
          label: const ColumnOrderLineWidget(
            columnTitle: Constants.orderLineCount,
          )),
      GridColumn(
          columnName: Constants.orderLineCost,
          label: const ColumnOrderLineWidget(
            columnTitle: Constants.orderLineCost,
          ))
    ];
  }
}

class ShowOrderLineCell extends StatelessWidget {
  const ShowOrderLineCell(
      {super.key,
      required this.bodyLarge,
      required this.orderSource,
      required this.details});
  final DataGridCellDetails details;
  final TextStyle bodyLarge;
  final OrderDataSource orderSource;

  @override
  Widget build(BuildContext context) {
    final value = orderSource.effectiveRows[details.rowColumnIndex.rowIndex - 1]
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

class ColumnOrderLineWidget extends StatelessWidget {
  const ColumnOrderLineWidget({
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

class OrderDataSource extends DataGridSource {
  OrderDataSource(
      {required List<OrderLineDTO> orderLines, required this.bodyLarge}) {
    orderLines.map((e) {
      if (e.product != null) {
        _categories.add(DataGridRow(cells: [
          DataGridCell(
              columnName: Constants.orderLineName, value: e.product!.name),
          DataGridCell(
              columnName: Constants.orderLineCount, value: e.count.toString()),
          DataGridCell(
              columnName: Constants.orderLineCost, value: '${e.cost}€'),
        ]));
      }
    }).toList();
  }

  final TextStyle bodyLarge;
  final List<DataGridRow> _categories = [];

  @override
  List<DataGridRow> get rows => _categories;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((order) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          order.value,
          maxLines: 1,
          style: bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }
}
