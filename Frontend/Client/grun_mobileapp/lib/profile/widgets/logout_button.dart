import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grun_mobileapp/utils/services/navigator_service.dart';

import 'package:provider/provider.dart';

import '../../login/ui/login_screen.dart';
import '../../utils/utils.dart';
import '../ui/profile_provider.dart';
import 'logout_dialog_android.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      child: MaterialButton(
        onPressed: () {
          _showDialog();
        },
        child: Row(children: [
          Icon(
            Icons.logout,
            color: Colors.red,
            size: size.width < 600 ? 25 : 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            Constants.logoutText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: size.width < 600 ? 22 : 32, color: Colors.black),
          )
        ]),
      ),
    );
  }

  void _showDialog() {
    showCupertinoDialog(
        context: NavigatorService.navigatorKey.currentContext!,
        builder: (context) {
          return const LogoutDialogAndroid();
        });
  }
}
