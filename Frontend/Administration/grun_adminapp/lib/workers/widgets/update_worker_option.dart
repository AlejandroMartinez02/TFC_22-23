import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/worker_provider.dart';
import 'update_worker_dialog.dart';

class UpdateWorker extends StatelessWidget {
  const UpdateWorker({super.key, required this.rowIndex});

  final int rowIndex;

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            workerProvider.updatedWorker =
                workerProvider.workers[rowIndex].copyWith();
            workerProvider.currentWorkerIndex = rowIndex;
            return UpdateWorkerDialog(
              bodyLarge: bodyLarge,
            );
          }),
      child: Container(
        color: Constants.blueColor,
        child: const Icon(
          FontAwesomeIcons.penToSquare,
          color: Colors.white,
        ),
      ),
    );
  }
}
