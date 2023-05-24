import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../utils/utils.dart';
import '../domain/entities/dish_dto.dart';
import '../widgets/widgets.dart';
import 'dish_provider.dart';

class DishScreen extends StatelessWidget {
  const DishScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dishProvider = Provider.of<DishProvider>(context);
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    if (dishProvider.isLoading) return const LoadingScreen();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          FadeInDown(
            duration: Constants.componentAnimationDuration,
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05, bottom: size.height * 0.05),
              child: _DishTitle(bodyLarge: bodyLarge),
            ),
          ),
          Expanded(
              child: FadeInRight(
            duration: Constants.componentAnimationDuration,
            child: DishDataGrid(
                dishesProvider: dishProvider, bodyLarge: bodyLarge),
          )),
        ],
      ),
    );
  }
}

class DishDataGrid extends StatelessWidget {
  const DishDataGrid({
    super.key,
    required this.dishesProvider,
    required this.bodyLarge,
  });

  final DishProvider dishesProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final dishesSource =
        DishesDataSource(bodyLarge: bodyLarge, dishes: dishesProvider.dishes);
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
            : cellTapFunction(context, details, dishesSource),
        allowSorting: true,
        allowSwiping: true,
        columnWidthMode: ColumnWidthMode.fill,
        highlightRowOnHover: true,
        source: dishesSource,
        columns: dataGridColumns,
        startSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            UpdateDish(rowIndex: rowIndex),
        endSwipeActionsBuilder: (context, dataGridRow, rowIndex) => DeleteDish(
          bodyLarge: bodyLarge,
          rowIndex: rowIndex,
        ),
        footerFrozenRowsCount: 1,
        footer: const AddDish(),
      ),
    );
  }

  Future<dynamic> cellTapFunction(BuildContext context,
      DataGridCellTapDetails details, DishesDataSource dishesSource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowDishCell(
              details: details,
              bodyLarge: bodyLarge,
              dishesSource: dishesSource);
        });
  }

  List<GridColumn> get dataGridColumns {
    return [
      GridColumn(
          columnName: Constants.photoDishText,
          label: const ColumnDishWidget(
            columnTitle: Constants.photoDishText,
          )),
      GridColumn(
          columnName: Constants.dishNameText,
          label: const ColumnDishWidget(
            columnTitle: Constants.dishNameText,
          )),
      GridColumn(
          columnName: Constants.descriptionDishText,
          label: const ColumnDishWidget(
            columnTitle: Constants.descriptionDishText,
          )),
      GridColumn(
          columnName: Constants.costDishText,
          label: const ColumnDishWidget(
            columnTitle: Constants.costDishText,
          )),
      GridColumn(
          columnName: Constants.ingredientsText,
          label: const ColumnDishWidget(
            columnTitle: Constants.ingredientsText,
          )),
      GridColumn(
          columnName: Constants.categoryDishText,
          label: const ColumnDishWidget(
            columnTitle: Constants.categoryDishText,
          )),
    ];
  }
}

class ShowDishCell extends StatelessWidget {
  const ShowDishCell(
      {super.key,
      required this.bodyLarge,
      required this.dishesSource,
      required this.details});
  final DataGridCellDetails details;
  final TextStyle bodyLarge;
  final DishesDataSource dishesSource;

  @override
  Widget build(BuildContext context) {
    final value = dishesSource
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
        details.column.columnName == Constants.photoDishText
            ? Container(
                alignment: Alignment.center,
                child: _dishPhotoShowCell(photo: value),
              )
            : Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: bodyLarge,
              ),
      ],
    ));
  }
}

class _DishTitle extends StatelessWidget {
  const _DishTitle({
    required this.bodyLarge,
  });

  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.dishTitle,
      style: bodyLarge.copyWith(fontSize: 35),
    );
  }
}

class ColumnDishWidget extends StatelessWidget {
  const ColumnDishWidget({
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

class DishesDataSource extends DataGridSource {
  DishesDataSource({required List<DishDTO> dishes, required this.bodyLarge}) {
    _dishes = dishes
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: "Foto", value: e.photo),
              DataGridCell(columnName: "Nombre", value: e.name),
              DataGridCell(columnName: "Descripción", value: e.description),
              DataGridCell(columnName: "Precio", value: e.cost),
              DataGridCell(columnName: "Ingredientes", value: e.ingredients),
              DataGridCell(columnName: "Categoria", value: e.category.name)
            ]))
        .toList();
  }

  final TextStyle bodyLarge;
  List<DataGridRow> _dishes = [];

  @override
  List<DataGridRow> get rows => _dishes;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dish) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: dish.columnName == Constants.photoDishText
            ? _dishPhotoCell(photo: dish.value)
            : dish.columnName == Constants.costDishText
                ? Text(
                    '${dish.value}€',
                    maxLines: 1,
                    style: bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    dish.value,
                    maxLines: 1,
                    style: bodyLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
      );
    }).toList());
  }
}

class _dishPhotoCell extends StatelessWidget {
  const _dishPhotoCell({
    required this.photo,
  });

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return photo == ''
        ? Image.asset(Constants.noImagePhoto)
        : CachedNetworkImage(
            height: 60,
            imageUrl: photo!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset(
                  "assets/foodLoader.gif",
                  fit: BoxFit.cover,
                ),
            errorWidget: (context, url, error) {
              return const Image(
                image: AssetImage(Constants.noImagePhoto),
                fit: BoxFit.cover,
              );
            });
  }
}

class _dishPhotoShowCell extends StatelessWidget {
  const _dishPhotoShowCell({
    required this.photo,
  });

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return photo == ''
        ? Image.asset(Constants.noImagePhoto, height: 300)
        : CachedNetworkImage(
            height: 300,
            imageUrl: photo!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset(
                  "assets/foodLoader.gif",
                  fit: BoxFit.cover,
                ),
            errorWidget: (context, url, error) {
              return const Image(
                image: AssetImage(Constants.noImagePhoto),
                fit: BoxFit.cover,
              );
            });
  }
}
