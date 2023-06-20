import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../utils/utils.dart';
import '../domain/entities/category_dto.dart';

import '../widgets/widgets.dart';
import 'category_provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    if (categoryProvider.isLoading) return const LoadingScreen();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          FadeInDown(
            duration: Constants.componentAnimationDuration,
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05, bottom: size.height * 0.05),
              child: _CategoryTitle(bodyLarge: bodyLarge),
            ),
          ),
          Expanded(
              child: FadeInRight(
            duration: Constants.componentAnimationDuration,
            child: CategoryDataGrid(
                categoryProvider: categoryProvider, bodyLarge: bodyLarge),
          )),
        ],
      ),
    );
  }
}

class CategoryDataGrid extends StatelessWidget {
  const CategoryDataGrid({
    super.key,
    required this.categoryProvider,
    required this.bodyLarge,
  });

  final CategoryProvider categoryProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final categorySource = CategoryDataSource(
        bodyLarge: bodyLarge, categories: categoryProvider.categories);
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
            : cellTapFunction(context, details, categorySource),
        allowSwiping: true,
        columnWidthMode: ColumnWidthMode.fill,
        highlightRowOnHover: true,
        source: categorySource,
        columns: dataGridColumns,
        startSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            UpdateCategory(rowIndex: rowIndex),
        endSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            DeleteCategory(
          bodyLarge: bodyLarge,
          rowIndex: rowIndex,
        ),
        footerFrozenRowsCount: 1,
        footer: const AddCategory(),
      ),
    );
  }

  Future<dynamic> cellTapFunction(BuildContext context,
      DataGridCellTapDetails details, CategoryDataSource categorySource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowCategoryCell(
              details: details,
              bodyLarge: bodyLarge,
              categorySource: categorySource);
        });
  }

  List<GridColumn> get dataGridColumns {
    return [
      GridColumn(
          columnName: Constants.photoCategoryText,
          label: const ColumnCategoryWidget(
            columnTitle: Constants.photoCategoryText,
          )),
      GridColumn(
          columnName: Constants.nameCategoryText,
          label: const ColumnCategoryWidget(
            columnTitle: Constants.nameCategoryText,
          )),
      GridColumn(
          columnName: Constants.descriptionCategoryText,
          label: const ColumnCategoryWidget(
            columnTitle: Constants.descriptionCategoryText,
          ))
    ];
  }
}

class ShowCategoryCell extends StatelessWidget {
  const ShowCategoryCell(
      {super.key,
      required this.bodyLarge,
      required this.categorySource,
      required this.details});
  final DataGridCellDetails details;
  final TextStyle bodyLarge;
  final CategoryDataSource categorySource;

  @override
  Widget build(BuildContext context) {
    final value = categorySource
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
        details.column.columnName == Constants.photoCategoryText
            ? Container(
                alignment: Alignment.center,
                child: _CategoryPhotoShowCell(photo: value),
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

class _CategoryTitle extends StatelessWidget {
  const _CategoryTitle({
    required this.bodyLarge,
  });

  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.categoryTitle,
      style: bodyLarge.copyWith(fontSize: 35),
    );
  }
}

class ColumnCategoryWidget extends StatelessWidget {
  const ColumnCategoryWidget({
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

class CategoryDataSource extends DataGridSource {
  CategoryDataSource(
      {required List<CategoryDTO> categories, required this.bodyLarge}) {
    _categories = categories
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: "Foto", value: e.photo),
              DataGridCell(columnName: "Nombre", value: e.name),
              DataGridCell(columnName: "Descripción", value: e.description),
            ]))
        .toList();
  }

  final TextStyle bodyLarge;
  List<DataGridRow> _categories = [];

  @override
  List<DataGridRow> get rows => _categories;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((category) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: category.columnName == Constants.photoCategoryText
            ? _CategoryPhotoCell(photo: category.value)
            : Text(
                category.value,
                maxLines: 1,
                style: bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
      );
    }).toList());
  }
}

class _CategoryPhotoCell extends StatelessWidget {
  const _CategoryPhotoCell({
    required this.photo,
  });

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return photo == ''
        ? const Image(
            image: AssetImage(Constants.noImagePhoto),
            fit: BoxFit.cover,
            height: 60,
          )
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

class _CategoryPhotoShowCell extends StatelessWidget {
  const _CategoryPhotoShowCell({
    required this.photo,
  });

  final String? photo;

  @override
  Widget build(BuildContext context) {
    return photo == ''
        ? const Image(
            image: AssetImage(Constants.noImagePhoto),
            fit: BoxFit.cover,
            height: 300,
          )
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
