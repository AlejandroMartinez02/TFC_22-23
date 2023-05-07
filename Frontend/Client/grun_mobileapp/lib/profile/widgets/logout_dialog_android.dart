import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../login/ui/login_screen.dart';
import '../../utils/utils.dart';
import '../ui/profile_provider.dart';

class LogoutDialogAndroid extends StatelessWidget {
  const LogoutDialogAndroid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      title: Text(
        Constants.logoutQuestion,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.black),
      ),
      actions: [
        MaterialButton(
          onPressed: () async {
            final logout =
                await Provider.of<ProfileProvider>(context, listen: false)
                    .logOut();
            if (logout) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    CreateRoutes.slideFadeIn(
                        direccion: const Offset(0, -1), screen: LoginScreen()));
              });
            } else {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
              NotificationService.showSnackBarOnMain(Constants.errorLogout);
            }
          },
          child: Text(
            Constants.logoutText,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.red),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            Constants.cancel,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}
