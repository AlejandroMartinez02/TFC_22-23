import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../../utils/widgets/loading_screen.dart';
import 'orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: size.height * 0.03);

    if (ordersProvider.isLoading) return const LoadingScreen();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Platform.isLinux || Platform.isIOS || Platform.isWindows
              ? SizedBox(
                  height: size.height * 0.05,
                  child: const CustomAppBar(),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Pedidos a realizar',
              style: bodyLarge.copyWith(
                  fontSize: size.height * 0.07, color: Colors.black),
            ),
          ),
          Expanded(
            child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(size.height * 0.02),
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ordersProvider.orders.isEmpty
                          ? Text(
                              'No hay pedidos a realizar. ¡Puedes descansar!',
                              style: bodyLarge.copyWith(color: Colors.black),
                            )
                          : Container(),
                      ...ordersProvider.orders.map((order) => FadeInDown(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(
                                            size.height * 0.03)),
                                    color: Constants.secondaryColor,
                                    border: Border.all(),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[900]!,
                                        offset: const Offset(0, 10), //(x,y)
                                        blurRadius: 5.0,
                                      )
                                    ]),
                                constraints:
                                    BoxConstraints(maxHeight: size.height),
                                width: size.width * 0.3,
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.height * 0.05),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.height * 0.01),
                                        child: Text(
                                          order.table == null
                                              ? 'Pedido para llevar / a domicilio'
                                              : 'Pedido para la mesa ${order.table!.tableNumber}',
                                          style: bodyLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Divider(
                                          thickness: 2, color: Colors.white),
                                      ...order.orderLines
                                          .map((e) => GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                              title: Text(
                                                                'Ingredientes',
                                                                style: bodyLarge
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .black),
                                                              ),
                                                              content: Text(
                                                                  e.product
                                                                      .ingredients,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: bodyLarge
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.black))));
                                                },
                                                onDoubleTap: () {
                                                  ordersProvider
                                                      .changeIsDone(e);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: e.isDone
                                                          ? const DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/strike_throught_line.png"))
                                                          : null),
                                                  padding: EdgeInsets.all(
                                                      size.height * 0.02),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          constraints:
                                                              BoxConstraints(
                                                                  maxWidth:
                                                                      size.width *
                                                                          0.2),
                                                          child: AutoSizeText(
                                                            e.product.name,
                                                            style: bodyLarge,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Text(
                                                          'x${e.count}',
                                                          style: bodyLarge,
                                                        )
                                                      ]),
                                                ),
                                              )),
                                      MaterialButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.height * 0.03),
                                        onPressed: () async {
                                          final response = await ordersProvider
                                              .updateOrder(order);
                                          SchedulerBinding.instance
                                              .addPostFrameCallback(
                                                  (timeStamp) {
                                            _checkResponse(response, context);
                                          });
                                        },
                                        child: Text(
                                          'Finalizar pedido',
                                          style: bodyLarge.copyWith(
                                              color: Colors.redAccent),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ))
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void _checkResponse(int response, BuildContext context) {
    switch (response) {
      case 200:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: 'Pedido finalizado',
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 500:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message:
                    'Ha ocurrido un error finalizando el pedido, por favor inténtalo de nuevo',
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
        break;
    }
  }
}
