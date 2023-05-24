import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../domain/entities/worker_dto.dart';
import '../ui/worker_provider.dart';

class RoleDropDown extends StatelessWidget {
  const RoleDropDown({
    super.key,
    required this.worker,
    required this.workerProvider,
    required this.bodyLarge,
  });
  final TextStyle bodyLarge;
  final WorkerDTO worker;
  final WorkerProvider workerProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.02),
      child: DropdownButton(
          isExpanded: true,
          value: worker.role,
          items: _dropDownOptions,
          onChanged: (value) =>
              workerProvider.changeRole(value.toString(), worker)),
    );
  }

  List<DropdownMenuItem<Object?>> get _dropDownOptions => [
        DropdownMenuItem(
          value: Constants.adminValue,
          child: Text(
            Constants.adminText,
            style: bodyLarge,
          ),
        ),
        DropdownMenuItem(
          value: Constants.chefValue,
          child: Text(
            Constants.chefText,
            style: bodyLarge,
          ),
        ),
        DropdownMenuItem(
          value: Constants.waiterValue,
          child: Text(
            Constants.waiterText,
            style: bodyLarge,
          ),
        ),
      ];
}
