import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../ui/profile_provider.dart';
import 'my_orders/my_orders_screen.dart';

class MyOrderOption extends StatelessWidget {
  const MyOrderOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final profileProvider = Provider.of<ProfileProvider>(context);
    return GestureDetector(
      onTap: () async {
        profileProvider.getOrders();
        Navigator.push(
            context,
            CreateRoutes.slideFadeIn(
                direccion: const Offset(1, 0), screen: const MyOrdersScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
        margin:
            EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.02),
        width: size.width,
        child: Text(
          Constants.myOrders,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black, fontSize: size.width < 600 ? 22 : 26),
        ),
      ),
    );
  }
}
