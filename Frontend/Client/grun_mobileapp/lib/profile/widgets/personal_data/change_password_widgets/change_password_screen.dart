import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grun_mobileapp/utils/services/notification_service.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/validators.dart';
import '../../../ui/profile_provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: size.height * 0.1,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(minWidth: 250, maxWidth: 400),
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          width: size.width,
          child: Form(
            key: profileProvider.changePasswordKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                _titleText(size: size),
                SizedBox(height: size.height * 0.05),
                _textField(
                  isValidated: false,
                  labelText: Constants.passwordTextField,
                  onChanged: (value) => profileProvider.oldPassword = value,
                ),
                SizedBox(height: size.height * 0.05),
                _textField(
                  isValidated: true,
                  labelText: Constants.newPasswordTextField,
                  onChanged: (value) => profileProvider.newPassword = value,
                ),
                SizedBox(height: size.height * 0.05),
                MaterialButton(
                  disabledColor: Colors.grey,
                  onPressed: profileProvider.isWaiting
                      ? null
                      : () async {
                          final response =
                              await profileProvider.changePassword();
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _checkResponse(response, context);
                          });
                        },
                  child: Text(
                    profileProvider.isWaiting
                        ? Constants.waiting
                        : Constants.changePaswwordButton,
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
    );
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 0:
        break;
      case 200:
        NotificationService.showSnackBar(Constants.changePasswordSuccess);
        Navigator.pop(context);
        break;
      case 401:
        NotificationService.showSnackBar(Constants.changePasswordFailed);
        break;
      case 500:
        NotificationService.showSnackBar(Constants.changePasswordError);
        break;
    }
  }
}

class _titleText extends StatelessWidget {
  const _titleText({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Text(
      "Cambiar la contraseña",
      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: Colors.black,
          fontSize: size.width < 600 ? 36 : 40,
          fontFamily: 'Monserrat',
          fontWeight: FontWeight.w300),
    );
  }
}

class _textField extends StatelessWidget {
  _textField(
      {super.key,
      required this.labelText,
      required this.onChanged,
      required this.isValidated});

  final String labelText;
  final Function(String?) onChanged;
  final bool isValidated;
  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    const passwordIcon = Icons.lock;
    final bodyLarge =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    return TextFormField(
      onChanged: onChanged,
      style: bodyLarge,
      validator:
          isValidated ? (value) => Validations.passwordValidator(value) : null,
      decoration: textboxDecoration(mainColor, passwordIcon, labelText),
    );
  }

  InputDecoration textboxDecoration(
      Color mainColor, IconData icon, String labelText) {
    return InputDecoration(
      label: Text(
        labelText,
        style: const TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
      ),
      prefixIcon: Icon(icon, color: mainColor),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: mainColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
        color: mainColor,
        width: 2,
      )),
    );
  }
}
