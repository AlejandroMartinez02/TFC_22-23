import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../utils/widgets/loading_screen.dart';
import '../domain/entities/user_dto.dart';
import 'users_provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UserProvider>(context);

    if (usersProvider.isLoading) return const LoadingScreen();
    return Scaffold(
      body: Center(
          child: SfDataGrid(
        source: UsersDataSource(users: usersProvider.users),
        columns: [
          GridColumn(
              columnName: "ID",
              label: const ColumnWidget(
                columnTitle: "ID",
              )),
          GridColumn(
              columnName: "Nombre",
              label: const ColumnWidget(
                columnTitle: "Nombre",
              )),
        ],
      )),
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
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Text(columnTitle),
    );
  }
}

class UsersDataSource extends DataGridSource {
  UsersDataSource({required List<UserDTO> users}) {
    _users = users
        .map((e) => DataGridRow(cells: [
              DataGridCell(columnName: "ID", value: e.id),
              DataGridCell(columnName: "Nombre", value: e.name),
              // DataGridCell(columnName: "Apellidos", value: e.lastname),
              // DataGridCell(columnName: "Correo", value: e.email),
              // DataGridCell(columnName: "Teléfono", value: e.phoneNumber),
              // DataGridCell(columnName: "Dirección", value: e.address)
            ]))
        .toList();
  }

  List<DataGridRow> _users = [];

  @override
  List<DataGridRow> get rows => _users;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((user) {
      return Container(
        child: Text(user.value),
      );
    }).toList());
  }
}
