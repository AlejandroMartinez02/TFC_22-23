import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../ui/users_provider.dart';
import 'edit_user_dialog.dart';

class EditUser extends StatelessWidget {
  const EditUser({super.key, required this.rowIndex});

  final int rowIndex;

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UserProvider>(context);
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Colors.black, fontSize: 20);
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            usersProvider.updatedUser =
                (usersProvider.users[rowIndex]).copyWith();
            usersProvider.currentUserIndex = rowIndex;
            return UpdateUserDialog(
              user: usersProvider.users[rowIndex],
              bodyLarge: bodyLarge,
              isLoading: usersProvider.isLoadingAction,
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
