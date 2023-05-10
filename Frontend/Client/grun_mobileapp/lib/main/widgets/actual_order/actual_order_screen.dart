import 'package:flutter/material.dart';
import 'package:grun_mobileapp/menu/ui/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';

class ActualOrderScreen extends StatelessWidget {
  const ActualOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainColor = Theme.of(context).primaryColor;
    final menuProvider = Provider.of<MenuProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          toolbarHeight: size.height * 0.1,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(top: size.height * 0.05),
            color: Colors.amber,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Constants.orderSummary,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontSize: size.width < 600 ? 28 : 32),
                )
              ],
            ),
          ),
        ));
  }
}
