import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';
import '../../../ui/profile_provider.dart';
import 'update_textbox.dart';

class EditPersonalDataScreen extends StatelessWidget {
  const EditPersonalDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: size.height * 0.1,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(minWidth: 250, maxWidth: 400),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              width: size.width,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: profileProvider.updateUserKey,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Text(
                      Constants.editProfileDataTitle,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontSize: size.width < 600 ? 26 : 30),
                    ),
                    _separation(size: size),
                    UpdateTextBox(
                      initialValue: profileProvider.updatedUser.name,
                      onChanged: (value) =>
                          profileProvider.updatedUser.name = value!,
                      inputType: TextInputType.name,
                      labelText: Constants.nameTextFiled,
                      validator: (value) =>
                          value!.isEmpty ? Constants.nameFieldError : null,
                    ),
                    _separation(size: size),
                    UpdateTextBox(
                      onChanged: (value) =>
                          profileProvider.updatedUser.lastname = value!,
                      inputType: TextInputType.name,
                      labelText: Constants.lastnameTextField,
                      validator: (value) =>
                          value!.isEmpty ? Constants.lastnameFieldError : null,
                      initialValue: profileProvider.updatedUser.lastname,
                    ),
                    _separation(size: size),
                    UpdateTextBox(
                      onChanged: (value) =>
                          profileProvider.updatedUser.address = value!,
                      inputType: TextInputType.streetAddress,
                      labelText: Constants.addressTextField,
                      validator: (value) =>
                          value!.isEmpty ? Constants.addressFieldError : null,
                      initialValue: profileProvider.updatedUser.address,
                    ),
                    _separation(size: size),
                    UpdateTextBox(
                      onChanged: (value) =>
                          profileProvider.updatedUser.phoneNumber = value!,
                      inputType: TextInputType.phone,
                      labelText: Constants.phoneTextField,
                      validator: (value) =>
                          value!.isEmpty ? Constants.phoneFieldError : null,
                      initialValue: profileProvider.updatedUser.phoneNumber,
                    ),
                    _separation(size: size),
                    UpdateTextBox(
                      onChanged: (value) =>
                          profileProvider.updatedUser.email = value!,
                      inputType: TextInputType.emailAddress,
                      labelText: Constants.emailAddressTextField,
                      validator: (value) =>
                          value!.isEmpty ? Constants.emailFieldError : null,
                      initialValue: profileProvider.updatedUser.email,
                    ),
                    _separation(size: size),
                    MaterialButton(
                      onPressed: profileProvider.isWaiting
                          ? null
                          : () async {
                              final response =
                                  await profileProvider.updateUser();
                              SchedulerBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                _checkResponse(response, context);
                              });
                            },
                      child: Text(
                        profileProvider.isWaiting
                            ? Constants.waiting
                            : Constants.updateUser,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Constants.secondaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 200:
        NotificationService.showSnackBar(Constants.updateUserSuccess);
        Navigator.pop(context);
        break;
      case 500:
        NotificationService.showSnackBar(Constants.updateUserError);
        break;
      case 100:
        NotificationService.showSnackBar(Constants.anyChangesDone);
        break;
    }
  }
}

class _separation extends StatelessWidget {
  const _separation({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.03,
    );
  }
}
