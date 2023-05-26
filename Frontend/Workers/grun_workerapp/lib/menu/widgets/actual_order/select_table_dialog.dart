import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../ui/menu_provider.dart';

class SelectTableDialog extends StatelessWidget {
  const SelectTableDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final bodyLarge =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
        title: Text(
          Constants.selectTable,
          textAlign: TextAlign.center,
          style: bodyLarge.copyWith(fontSize: size.width < 600 ? 24 : 30),
        ),
        actions: _actions(context, menuProvider),
        content: SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.6,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: GridView.count(
                physics: const ClampingScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 3,
                children: List.generate(menuProvider.tables.length, (index) {
                  final isSelected = menuProvider.tableNumberSelected ==
                      menuProvider.tables[index].tableNumber;
                  final isInUse = menuProvider.tables[index].isInUse;
                  return GestureDetector(
                    onTap: () => isInUse
                        ? null
                        : menuProvider.changeSelectedTable(
                            menuProvider.tables[index].tableNumber),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: isInUse ? Colors.grey : Colors.black),
                          color: isSelected
                              ? Constants.secondaryColor
                              : Colors.white),
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(size.height * 0.01),
                      height: size.height * 0.25,
                      child: Text(
                        menuProvider.tables[index].tableNumber == -1
                            ? 'Ninguna'
                            : 'Mesa ${menuProvider.tables[index].tableNumber}',
                        style: bodyLarge.copyWith(
                            color: isInUse
                                ? Colors.grey
                                : isSelected
                                    ? Colors.white
                                    : Colors.black),
                      ),
                    ),
                  );
                }),
              ),
            )));
  }

  List<Widget> _actions(BuildContext context, MenuProvider menuProvider) {
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Constants.secondaryColor);
    return [
      MaterialButton(
        onPressed: menuProvider.tableNumberSelected == 0
            ? null
            : () async {
                final selectedTable = menuProvider.tableNumberSelected;
                if (selectedTable != -1) {
                  menuProvider.tables[selectedTable - 1].isInUse = true;
                  menuProvider.order.table =
                      menuProvider.tables[selectedTable - 1];
                }
                final response = await menuProvider.finishOrder();
                SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                  if (response == 200) {
                    menuProvider.changeSelectedTable(0);
                  }
                  _checkResponse(status: response, context: context);
                });
              },
        child: Text(Constants.selectTable,
            style: bodyLarge.copyWith(
                color: menuProvider.tableNumberSelected == 0
                    ? Colors.grey
                    : Constants.secondaryColor)),
      ),
      MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            menuProvider.changeSelectedTable(0);
          },
          child: Text(Constants.cancel, style: bodyLarge))
    ];
  }

  void _checkResponse({required int status, required BuildContext context}) {
    switch (status) {
      case 200:
        Navigator.pop(context);
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.createdOrder,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);

        break;
      case 500:
        Flushbar(
                backgroundColor: Theme.of(context).primaryColor,
                message: Constants.errorCreatedOrder,
                messageSize: 20,
                duration: Constants.toastDuration)
            .show(context);
    }
  }
}


/*
 final response = await menuProvider.finishOrder();

          _checkResponse(status: response);
*/