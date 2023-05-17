import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../login/ui/login_screen.dart';
import '../../users/ui/users_screen.dart';
import '../../utils/utils.dart';
import '../ui/main_provider.dart';

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
        Constants.logoutTitle,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.black),
      ),
      actions: [
        MaterialButton(
          onPressed: () async {
            final mainProvider =
                Provider.of<MainProvider>(context, listen: false);
            final logout = await mainProvider.logOut();
            if (logout) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    CreateRoutes.slideFadeIn(
                        direccion: const Offset(0, -1), screen: LoginScreen()));
                mainProvider.currentPage = const UsersScreen();
              });
            } else {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
                Flushbar(
                        backgroundColor: Theme.of(context).primaryColor,
                        message: Constants.errorLogout,
                        messageSize: 20,
                        duration: Constants.toastDuration)
                    .show(context);
              });
            }
          },
          child: Text(
            Constants.logout,
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
