import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../domain/entities/user_dto.dart';
import '../ui/users_provider.dart';
import '../../utils/widgets/update_textbox.dart';

class UpdateUserDialog extends StatelessWidget {
  const UpdateUserDialog({
    super.key,
    required this.user,
    required this.isLoading,
    required this.bodyLarge,
  });
  final bool isLoading;
  final UserDTO user;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              Constants.updateUser,
              style: bodyLarge.copyWith(color: Colors.black),
            ),
            actions: _dialogActions(context, userProvider),
            content: Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.2),
              child: _EditUserForm(userProvider: userProvider, user: user),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _dialogActions(BuildContext context, UserProvider userProvider) {
    return [
      MaterialButton(
        onPressed: isLoading
            ? null
            : () {
                Navigator.pop(context);
              },
        child: Text(
          Constants.cancel,
          style: bodyLarge.copyWith(
              color: isLoading ? Colors.grey : Constants.secondaryColor),
        ),
      ),
      MaterialButton(
        onPressed: isLoading
            ? null
            : () async {
                final response = await userProvider.updateUser();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  _checkResponse(response, context);
                });
              },
        child: Text(
          isLoading ? Constants.waiting : Constants.updateUser,
          style: bodyLarge.copyWith(
              color: isLoading ? Colors.grey : Constants.secondaryColor),
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
                message: Constants.updateUserSuccess,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 403:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateUserError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;

      case 404:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.updateUserError,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
      case 100:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.anyChangesDoneUser,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}

class _EditUserForm extends StatelessWidget {
  const _EditUserForm({
    required this.userProvider,
    required this.user,
  });

  final UserProvider userProvider;
  final UserDTO user;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: userProvider.updateUserKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFormTextBox(
            maxLines: 1,
            hintText: Constants.nameHint,
            inputType: TextInputType.name,
            labelText: Constants.nameText,
            onChanged: (value) => userProvider.updatedUser.name = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.nameFieldError : null,
            initialValue: user.name,
          ),
          CustomFormTextBox(
            maxLines: 1,
            hintText: Constants.lastnameHint,
            inputType: TextInputType.name,
            labelText: Constants.lastnameText,
            onChanged: (value) => userProvider.updatedUser.lastname = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.lastnameFieldError : null,
            initialValue: user.lastname,
          ),
          CustomFormTextBox(
            maxLines: 1,
            hintText: Constants.emailHint,
            inputType: TextInputType.emailAddress,
            labelText: Constants.emailAddressText,
            onChanged: (value) => userProvider.updatedUser.email = value!,
            validator: (value) => Validations.emailValidator(value),
            initialValue: user.email,
          ),
          CustomFormTextBox(
            maxLines: 1,
            hintText: Constants.phoneHint,
            inputType: TextInputType.phone,
            labelText: Constants.phoneText,
            onChanged: (value) => userProvider.updatedUser.phoneNumber = value!,
            validator: (value) => Validations.phoneValidator(value),
            initialValue: user.phoneNumber,
          ),
          CustomFormTextBox(
            maxLines: 2,
            hintText: Constants.addressHint,
            inputType: TextInputType.streetAddress,
            labelText: Constants.addressText,
            onChanged: (value) => userProvider.updatedUser.address = value!,
            validator: (value) =>
                value!.isEmpty ? Constants.addressFieldError : null,
            initialValue: user.address,
          ),
        ],
      ),
    );
  }
}
