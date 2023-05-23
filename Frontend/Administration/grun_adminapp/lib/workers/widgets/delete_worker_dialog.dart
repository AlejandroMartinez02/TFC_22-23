import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/worker_provider.dart';

class DeleteWorker extends StatelessWidget {
  const DeleteWorker(
      {super.key, required this.rowIndex, required this.bodyLarge});

  final int rowIndex;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final workerProvider = Provider.of<WorkerProvider>(context);
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                actions: _dialogActions(context, workerProvider),
                content: Text(
                  Constants.deleteWorker,
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

  List<Widget> _dialogActions(
      BuildContext context, WorkerProvider workerProvider) {
    return [
      MaterialButton(
        onPressed: workerProvider.isLoadingAction
            ? null
            : () async {
                workerProvider.currentWorkerIndex = rowIndex;
                final response = await workerProvider
                    .deleteWorker(workerProvider.workers[rowIndex].id);
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          workerProvider.isLoadingAction
              ? Constants.waiting
              : Constants.deleteWorker,
          style: bodyLarge.copyWith(
              color: workerProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.redColor),
        ),
      ),
      MaterialButton(
        onPressed: workerProvider.isLoadingAction
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: workerProvider.isLoadingAction
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
                message: Constants.deleteWorkerSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteWorkerError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.deleteWorkerError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}
