import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../utils/constants.dart';
import '../domain/entities/worker_dto.dart';

class AgePicker extends StatelessWidget {
  const AgePicker({
    super.key,
    required this.worker,
  });

  final WorkerDTO worker;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      width: size.width * 0.4,
      child: SfDateRangePicker(
          selectionColor: Constants.secondaryColor,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          initialDisplayDate: DateTime.tryParse(worker.age) ??
              DateTime.now().subtract(Constants.minAgeWorker),
          initialSelectedDate: DateTime.tryParse(worker.age) ??
              DateTime.now().subtract(Constants.minAgeWorker),
          minDate: DateTime.now().subtract(Constants.maxAgeWorker),
          maxDate: DateTime.now().subtract(Constants.minAgeWorker),
          onSelectionChanged: (args) {
            worker.age = (args.value as DateTime).toString();
          }),
    );
  }
}
/*



*/ 