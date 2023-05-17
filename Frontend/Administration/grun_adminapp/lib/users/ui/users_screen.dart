import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/services/socket_service.dart';
import '../../utils/utils.dart';
import '../domain/entities/user_dto.dart';
import '../widgets/widgets.dart';
import 'users_provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    if (usersProvider.isLoading) return const LoadingScreen();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: size.height * 0.05, bottom: size.height * 0.05),
            child: _UsersTitle(bodyLarge: bodyLarge),
          ),
          UsersDataGrid(usersProvider: usersProvider, bodyLarge: bodyLarge),
        ],
      ),
    );
  }
}

class UsersDataGrid extends StatelessWidget {
  const UsersDataGrid({
    super.key,
    required this.usersProvider,
    required this.bodyLarge,
  });

  final UserProvider usersProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final usersSource =
        UsersDataSource(bodyLarge: bodyLarge, users: usersProvider.users);
    final sockets = Provider.of<SocketService>(context);

    return SfDataGrid(
        verticalScrollPhysics: ClampingScrollPhysics(),
        horizontalScrollPhysics: ClampingScrollPhysics(),
        onCellTap: (details) => details.rowColumnIndex.rowIndex - 1 < 0
            ? sockets.emit()
            : cellTapFunction(context, details, usersSource),
        allowSorting: true,
        allowSwiping: true,
        columnWidthMode: ColumnWidthMode.fill,
        highlightRowOnHover: true,
        source: usersSource,
        columns: dataGridColumns,
        startSwipeActionsBuilder: (context, dataGridRow, rowIndex) =>
            EditUser(rowIndex: rowIndex),
        endSwipeActionsBuilder: (context, dataGridRow, rowIndex) => DeleteUser(
              rowIndex: rowIndex,
              bodyLarge: bodyLarge,
            ));
  }

  Future<dynamic> cellTapFunction(BuildContext context,
      DataGridCellTapDetails details, UsersDataSource usersSource) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShowUserCell(
              details: details, bodyLarge: bodyLarge, usersSource: usersSource);
        });
  }

  List<GridColumn> get dataGridColumns {
    return [
      GridColumn(
          columnName: Constants.nameText,
          label: const ColumnWidget(
            columnTitle: Constants.nameText,
          )),
      GridColumn(
          columnName: Constants.lastnameText,
          label: const ColumnWidget(
            columnTitle: Constants.lastnameText,
          )),
      GridColumn(
          columnName: Constants.emailAddressText,
          label: const ColumnWidget(
            columnTitle: Constants.emailAddressText,
          )),
      GridColumn(
          columnName: Constants.phoneText,
          label: const ColumnWidget(
            columnTitle: Constants.phoneText,
          )),
      GridColumn(
          columnName: Constants.addressText,
          label: const ColumnWidget(
            columnTitle: Constants.addressText,
          )),
    ];
  }
}

class DeleteUser extends StatelessWidget {
  const DeleteUser(
      {super.key, required this.rowIndex, required this.bodyLarge});

  final int rowIndex;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: _dialogActions(context, userProvider),
                content: Text(
                  Constants.deleteUser,
                  style: bodyLarge,
                ),
              );
            });
      },
      child: Container(
        color: Constants.redColor,
        child: const Icon(FontAwesomeIcons.trashCan, color: Colors.white),
      ),
    );
  }

  List<Widget> _dialogActions(BuildContext context, UserProvider userProvider) {
    return [
      MaterialButton(
        onPressed: userProvider.isLoadingAction
            ? null
            : () async {
                userProvider.currentUserIndex = rowIndex;
                final response = await userProvider
                    .deleteUser(userProvider.users[rowIndex].id);
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          userProvider.isLoadingAction
              ? Constants.waiting
              : Constants.deleteUserButton,
          style: bodyLarge.copyWith(
              color: userProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.redColor),
        ),
      ),
      MaterialButton(
        onPressed: userProvider.isLoadingAction
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: userProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.secondaryColor),
        ),
      )
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 200:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.actionUserError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.actionUserError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class ShowUserCell extends StatelessWidget {
  const ShowUserCell(
      {super.key,
      required this.bodyLarge,
      required this.usersSource,
      required this.details});
  final DataGridCellDetails details;
  final TextStyle bodyLarge;
  final UsersDataSource usersSource;

  @override
  Widget build(BuildContext context) {
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
          usersSource.effectiveRows[details.rowColumnIndex.rowIndex - 1]
              .getCells()[details.rowColumnIndex.columnIndex]
              .value,
          textAlign: TextAlign.center,
          style: bodyLarge,
        ),
      ],
    ));
  }
}

class _UsersTitle extends StatelessWidget {
  const _UsersTitle({
    required this.bodyLarge,
  });

  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Text(
      Constants.userTitle,
      style: bodyLarge.copyWith(fontSize: 35),
    );
  }
}

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({
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

class UsersDataSource extends DataGridSource {
  UsersDataSource({required List<UserDTO> users, required this.bodyLarge}) {
    _users = users
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: "Nombre", value: e.name),
              DataGridCell(columnName: "Apellidos", value: e.lastname),
              DataGridCell(columnName: "Correo", value: e.email),
              DataGridCell(columnName: "Teléfono", value: e.phoneNumber),
              DataGridCell(columnName: "Dirección", value: e.address)
            ]))
        .toList();
  }

  final TextStyle bodyLarge;
  List<DataGridRow> _users = [];

  @override
  List<DataGridRow> get rows => _users;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((user) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          user.value,
          maxLines: 1,
          style: bodyLarge,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }
}
