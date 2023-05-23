import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../utils/widgets/update_textbox.dart';
import '../ui/worker_provider.dart';
import 'widgets.dart';

class UpdateWorkerDialog extends StatelessWidget {
  const UpdateWorkerDialog({
    super.key,
    required this.bodyLarge,
  });
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final workerProvider = Provider.of<WorkerProvider>(context);
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              Constants.updateWorker,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, workerProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _EditWorkerForm(workerProvider: workerProvider),
            ),
          ),
        ),
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
                final response = await workerProvider.updateWorker();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          workerProvider.isLoadingAction
              ? Constants.waiting
              : Constants.updateWorker,
          style: bodyLarge.copyWith(
              color: workerProvider.isLoadingAction
                  ? Colors.grey
                  : Constants.secondaryColor),
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
      ),
    ];
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 200:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateWorkerSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateWorkerError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 500:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateWorkerError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 100:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.anyChangeDoneDish,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _EditWorkerForm extends StatelessWidget {
  const _EditWorkerForm({required this.workerProvider});

  final WorkerProvider workerProvider;

  @override
  Widget build(BuildContext context) {
    final bodyLarge =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    return Form(
      key: workerProvider.updateWorkerKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
            initialValue: workerProvider.updatedWorker.name,
            maxLines: 1,
            hintText: Constants.workerNameHint,
            inputType: TextInputType.name,
            labelText: Constants.workerName,
            onChanged: (value) => workerProvider.updatedWorker.name = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.workerNameError : null,
          ),
          CustomFormTextBox(
            initialValue: workerProvider.updatedWorker.lastname,
            maxLines: 1,
            hintText: Constants.workerLastnameHint,
            inputType: TextInputType.name,
            labelText: Constants.workerLastname,
            onChanged: (value) =>
                workerProvider.updatedWorker.lastname = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.workerLastnameError : null,
          ),
          CustomFormTextBox(
            initialValue: workerProvider.updatedWorker.email,
            maxLines: 1,
            hintText: Constants.workerEmailHint,
            inputType: TextInputType.emailAddress,
            labelText: Constants.workerEmail,
            onChanged: (value) => workerProvider.updatedWorker.email = value!,
            validator: (value) => Validations.emailValidator(value),
          ),
          CustomFormTextBox(
              initialValue: workerProvider.updatedWorker.phone,
              maxLines: 1,
              hintText: Constants.workerPhoneHint,
              inputType: TextInputType.phone,
              labelText: Constants.workerPhone,
              onChanged: (value) => workerProvider.updatedWorker.phone = value!,
              validator: (value) => Validations.phoneValidator(value)),
          CustomFormTextBox(
            initialValue: workerProvider.updatedWorker.salary.toString(),
            maxLines: 1,
            hintText: Constants.workerSalaryHint,
            inputType: TextInputType.number,
            labelText: Constants.workerSalary,
            onChanged: (value) => workerProvider.updatedWorker.salary =
                int.tryParse(value ?? '0')!,
            validator: (value) => int.tryParse(value ?? '0')! > 0
                ? null
                : Constants.workerSalaryError,
          ),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.workerPassword,
            inputType: TextInputType.name,
            labelText: Constants.workerPassword,
            onChanged: (value) =>
                workerProvider.updatedWorker.password = value!,
            validator: (value) =>
                value!.isEmpty ? null : Validations.passwordValidator(value),
          ),
          MaritalStatusDropDown(
              bodyLarge: bodyLarge,
              worker: workerProvider.updatedWorker,
              workerProvider: workerProvider),
          RoleDropDown(
              bodyLarge: bodyLarge,
              worker: workerProvider.updatedWorker,
              workerProvider: workerProvider),
          AgePicker(worker: workerProvider.updatedWorker)
        ],
      ),
    );
  }
}
