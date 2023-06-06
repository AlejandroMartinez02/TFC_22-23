import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../domain/entities/worker_dto.dart';
import '../ui/worker_provider.dart';

// ignore: must_be_immutable
class MaritalStatusDropDown extends StatelessWidget {
  MaritalStatusDropDown({
    required this.bodyLarge,
    required this.worker,
    super.key,
    required this.workerProvider,
  });

  TextStyle bodyLarge;
  WorkerDTO worker;
  WorkerProvider workerProvider;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      child: DropdownButton(
          isExpanded: true,
          items: _dropDownOptions,
          value: worker.maritalStatus,
          onChanged: (value) =>
              workerProvider.changeMaritalStatus(value.toString(), worker)),
    );
  }

  List<DropdownMenuItem<Object?>> get _dropDownOptions => [
        DropdownMenuItem(
          value: Constants.single,
          child: Text(
            Constants.single,
            style: bodyLarge,
          ),
        ),
        DropdownMenuItem(
          value: Constants.married,
          child: Text(
            Constants.married,
            style: bodyLarge,
          ),
        ),
        DropdownMenuItem(
          value: Constants.engagement,
          child: Text(
            Constants.engagement,
            style: bodyLarge,
          ),
        ),
        DropdownMenuItem(
          value: Constants.other,
          child: Text(
            Constants.other,
            style: bodyLarge,
          ),
        ),
      ];
}
