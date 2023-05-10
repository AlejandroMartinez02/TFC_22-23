import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/widgets/loading_screen.dart';
import '../../ui/profile_provider.dart';
import 'order_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainColor = Theme.of(context).primaryColor;
    final profileProvider = Provider.of<ProfileProvider>(context);
    final size = MediaQuery.of(context).size;
    if (profileProvider.isLoading) return const LoadingScreen();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * 0.1,
          backgroundColor: mainColor,
          title: Text(
            Constants.myOrders,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: size.width < 600 ? 20 : 22),
          ),
        ),
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: profileProvider.orders.length,
          itemBuilder: (_, int index) {
            return OrderCard(
              order: profileProvider.orders[index],
              index: profileProvider.orders.length - index,
            );
          },
        ));
  }
}
