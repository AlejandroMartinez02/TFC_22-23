import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/utils.dart';
import '../domain/entities/order_dto.dart';
import '../widgets/delete_order_option.dart';
import '../widgets/order_footer.dart';
import '../widgets/visualize_order_option.dart';
import 'order_provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    if (orderProvider.isLoading) return const LoadingScreen();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          FadeInDown(
            duration: Constants.componentAnimationDuration,
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05, bottom: size.height * 0.05),
              child: _OrderTitle(bodyLarge: bodyLarge),
            ),
          ),
          Expanded(
              child: FadeInRight(
            duration: Constants.componentAnimationDuration,
            child: OrderDataGrid(
                orderProvider: orderProvider, bodyLarge: bodyLarge),
          )),
        ],
      ),
    );
  }
}

class OrderDataGrid extends StatelessWidget {
  const OrderDataGrid({
    super.key,
    required this.orderProvider,
    required this.bodyLarge,
  });

  final OrderProvider orderProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final orderSource =
        OrderDataSource(bodyLarge: bodyLarge, categories: orderProvider.orders);
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
            : cellTapFunction(context, details, orderSource),
        allowSwiping: true,
        columnWidthMode: ColumnWidthMode.fill,
        highlightRowOnHover: true,
        source: orderSource,
        columns: dataGridColumns,
        startSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            VisualizeOrderOption(rowIndex: rowIndex),
        endSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            DeleteOrderOption(
          bodyLarge: bodyLarge,
          rowIndex: rowIndex,
        ),
        footerFrozenRowsCount: 1,
        footer: OrderFooter(
          totalCost: orderProvider.getTotalCost(),
        ),
      ),
    );
  }

  Future<dynamic> cellTapFunction(BuildContext context,
      DataGridCellTapDetails details, OrderDataSource orderSource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowOrderCell(
              details: details, bodyLarge: bodyLarge, orderSource: orderSource);
        });
  }

  List<GridColumn> get dataGridColumns {
    return [
      GridColumn(
          columnName: Constants.orderDate,
          label: const ColumnOrderWidget(
            columnTitle: Constants.orderDate,
          )),
      GridColumn(
          columnName: Constants.orderCost,
          label: const ColumnOrderWidget(
            columnTitle: Constants.orderCost,
          )),
      GridColumn(
          columnName: Constants.orderState,
          label: const ColumnOrderWidget(
            columnTitle: Constants.orderState,
          ))
    ];
  }
}

class ShowOrderCell extends StatelessWidget {
  const ShowOrderCell(
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

class _OrderTitle extends StatelessWidget {
  const _OrderTitle({
    required this.bodyLarge,
  });

  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.orderTitle,
      style: bodyLarge.copyWith(fontSize: 35),
    );
  }
}

class ColumnOrderWidget extends StatelessWidget {
  const ColumnOrderWidget({
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
      {required List<OrderDTO> categories, required this.bodyLarge}) {
    _categories = categories
        .map((e) => DataGridRow(cells: [
              DataGridCell(
                  columnName: Constants.orderDate,
                  value: convertToDate(e.date)),
              DataGridCell(
                  columnName: Constants.orderCost,
                  value: e.totalCost.toString()),
              DataGridCell(columnName: Constants.orderState, value: e.state),
            ]))
        .toList();
  }

  String convertToDate(DateTime date) {
    final minutes =
        date.minute.toString().length == 1 ? '0${date.minute}' : date.minute;
    return '${date.day}-${date.month}-${date.year}  ${date.hour}:$minutes';
  }

  final TextStyle bodyLarge;
  List<DataGridRow> _categories = [];

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
