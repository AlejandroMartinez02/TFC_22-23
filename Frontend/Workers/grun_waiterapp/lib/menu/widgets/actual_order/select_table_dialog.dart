import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:flutter/services.dart' show rootBundle;

import 'package:another_flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../utils/constants.dart';
import '../../domain/entity/order_dto.dart';
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
    final primaryColor = Theme.of(context).primaryColor;
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
                  _checkResponse(
                      status: response,
                      context: context,
                      order: menuProvider.order,
                      color: primaryColor);
                  menuProvider.restartOrder();

                  Navigator.pop(context);
                  Navigator.pop(context);
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

  void _checkResponse(
      {required int status,
      required BuildContext context,
      required OrderDTO order,
      required Color color}) async {
    switch (status) {
      case 200:
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Flushbar(
                  backgroundColor: color,
                  message: Constants.createdOrder,
                  messageSize: 20,
                  duration: Constants.toastDuration)
              .show(context);
        });
        await printOrder(order);

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

printOrder(OrderDTO order) async {
  final pdf = pw.Document();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/light_logo.png')).buffer.asUint8List(),
  );
  final nameFile =
      '${order.date.year}${order.date.month}${order.date.day}${order.date.hour}${order.date.minute}${order.totalCost.toString().replaceAll(RegExp(r'.'), '')}';
  final table = order.table != null
      ? 'Mesa: ${order.table!.tableNumber}'
      : 'Pedido a recoger/domicilio';

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 10),
              child: pw.Image(image, height: 120, width: 120)),
          pw.Text(
              '${Constants.grunAdress} \n ${Constants.grunPhone} \n ${Constants.slogan}  \n ${Constants.webPage}',
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(fontSize: 8, font: pw.Font.courier())),
          pw.Divider(color: PdfColors.grey700),
          pw.Center(
              child: pw.Text('Pedido $nameFile',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 13, font: pw.Font.courier()))),
          pw.Center(
              child: pw.Text(table,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(fontSize: 9, font: pw.Font.courier()))),
          pw.Text('Atentido/a por: ${order.worker!.name}',
              style: pw.TextStyle(fontSize: 9, font: pw.Font.courier())),
          pw.Text(
              'Fecha: ${order.date.day}-${order.date.month}-${order.date.year} ${order.date.hour}:${order.date.minute}',
              style: pw.TextStyle(fontSize: 9, font: pw.Font.courier())),
          pw.Divider(color: PdfColors.grey700),
          pw.Table(children: [
            pw.TableRow(children: [
              pw.Text(Constants.productTicketColumn,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(fontSize: 9, font: pw.Font.courier())),
              pw.Text(Constants.unitsTicketColumn,
                  style: pw.TextStyle(fontSize: 8, font: pw.Font.courier())),
              pw.Text(Constants.costTicketColumn,
                  style: pw.TextStyle(fontSize: 9, font: pw.Font.courier())),
              pw.Text(Constants.totalCostTicketColumn,
                  style: pw.TextStyle(fontSize: 9, font: pw.Font.courier()))
            ]),
            pw.TableRow(children: [
              pw.SizedBox(
                height: 5,
              )
            ]),
            ...order.orderLines.map((e) => pw.TableRow(children: [
                  pw.Text(
                      e.product.name.substring(0, e.product.name.length ~/ 2),
                      style:
                          pw.TextStyle(fontSize: 8, font: pw.Font.courier())),
                  pw.Text(e.count.toString(),
                      textAlign: pw.TextAlign.center,
                      style:
                          pw.TextStyle(fontSize: 9, font: pw.Font.courier())),
                  pw.Text(e.product.cost.toStringAsFixed(2),
                      style:
                          pw.TextStyle(fontSize: 9, font: pw.Font.courier())),
                  pw.Text(e.cost.toStringAsFixed(2),
                      style: pw.TextStyle(fontSize: 9, font: pw.Font.courier()))
                ])),
          ]),
          pw.Divider(color: PdfColors.grey700),
          pw.Text('Coste total: ${order.totalCost.toStringAsFixed(2)} EUR',
              style: pw.TextStyle(fontSize: 14, font: pw.Font.courier())),
        ]);
      })); // P
  final List<int> bytes = await pdf.save();

  await saveAndLaunchFile(bytes, '$nameFile.pdf', pdf);
}

Future<void> saveAndLaunchFile(
  List<int> bytes,
  String fileName,
  pw.Document pdf,
) async {
  String? path;
  if (Platform.isAndroid || Platform.isIOS) {
    final Directory? directory =
        await path_provider.getExternalStorageDirectory();
    path = directory!.path;
  } else {
    Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    path = directory.path;
  }
  final File file =
      File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
  await file.writeAsBytes(bytes);
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
