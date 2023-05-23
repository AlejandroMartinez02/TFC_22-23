import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../utils/widgets/update_textbox.dart';
import '../domain/entities/worker_dto.dart';
import '../ui/worker_provider.dart';
import 'widgets.dart';

class AddWorkerDialog extends StatelessWidget {
  const AddWorkerDialog({
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
              Constants.addWorker,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, workerProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _AddWorkerForm(
                  workerProvider: workerProvider,
                  worker: workerProvider.newWorker),
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
                final response = await workerProvider.addWorker();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          workerProvider.isLoadingAction
              ? Constants.waiting
              : Constants.addWorker,
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
      case 201:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addWorkerSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addWorkerError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 500:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.addWorkerError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _AddWorkerForm extends StatelessWidget {
  const _AddWorkerForm({
    required this.workerProvider,
    required this.worker,
  });

  final WorkerProvider workerProvider;
  final WorkerDTO worker;

  @override
  Widget build(BuildContext context) {
    final bodyLarge =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    return Form(
      key: workerProvider.addWorkerKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.workerNameHint,
            inputType: TextInputType.name,
            labelText: Constants.workerName,
            onChanged: (value) => workerProvider.newWorker.name = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.workerNameError : null,
          ),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.workerLastnameHint,
            inputType: TextInputType.name,
            labelText: Constants.workerLastname,
            onChanged: (value) => workerProvider.newWorker.lastname = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.workerLastnameError : null,
          ),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.workerEmailHint,
            inputType: TextInputType.emailAddress,
            labelText: Constants.workerEmail,
            onChanged: (value) => workerProvider.newWorker.email = value!,
            validator: (value) => Validations.emailValidator(value),
          ),
          CustomFormTextBox(
              initialValue: '',
              maxLines: 1,
              hintText: Constants.workerPhoneHint,
              inputType: TextInputType.phone,
              labelText: Constants.workerPhone,
              onChanged: (value) => workerProvider.newWorker.phone = value!,
              validator: (value) => Validations.phoneValidator(value)),
          CustomFormTextBox(
            initialValue: '',
            maxLines: 1,
            hintText: Constants.workerSalaryHint,
            inputType: TextInputType.number,
            labelText: Constants.workerSalary,
            onChanged: (value) =>
                workerProvider.newWorker.salary = int.tryParse(value ?? '0')!,
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
                workerProvider.newWorker.salary = int.tryParse(value ?? '0')!,
            validator: (value) => Validations.passwordValidator(value),
          ),
          MaritalStatusDropDown(
              bodyLarge: bodyLarge,
              worker: workerProvider.newWorker,
              workerProvider: workerProvider),
          RoleDropDown(
              bodyLarge: bodyLarge,
              worker: workerProvider.newWorker,
              workerProvider: workerProvider),
          AgePicker(worker: workerProvider.newWorker)
        ],
      ),
    );
  }
}
