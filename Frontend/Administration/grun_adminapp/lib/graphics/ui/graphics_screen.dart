import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/utils.dart';
import '../domain/entities/product_graphics_dto.dart';
import 'graphics_provider.dart';

class GraphicsScreen extends StatelessWidget {
  const GraphicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyLarge =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    final size = MediaQuery.of(context).size;
    final graphicsProvider = Provider.of<GraphicsProvider>(context);
    if (graphicsProvider.isLoading) return const LoadingScreen();
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.7,
                margin: EdgeInsets.all(size.width * 0.02),
                child: SfCircularChart(
                  title: ChartTitle(
                      text: Constants.getTitle(graphicsProvider.isBestSelected,
                          graphicsProvider.currentNumOrders.abs()),
                      textStyle: bodyLarge),
                  legend: Legend(
                      iconHeight: 40,
                      iconWidth: 40,
                      isVisible: true,
                      position: LegendPosition.left,
                      overflowMode: LegendItemOverflowMode.wrap,
                      legendItemBuilder: (String name, dynamic series,
                          dynamic point, int index) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                color: (point as ChartPoint).color,
                                height: 10,
                                width: 10),
                            const SizedBox(width: 10),
                            Text(
                              name,
                              style: bodyLarge,
                            ),
                          ],
                        );
                      }),
                  series: <CircularSeries>[
                    PieSeries<ProductGraphicsDTO, String>(
                        dataSource: graphicsProvider.numProducts[
                            graphicsProvider.currentNumOrders.toString()],
                        dataLabelMapper: (ProductGraphicsDTO data, index) =>
                            data.count.toString(),
                        xValueMapper: (ProductGraphicsDTO data, _) =>
                            data.product.name,
                        yValueMapper: (ProductGraphicsDTO data, _) =>
                            data.count,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true, textStyle: bodyLarge))
                  ],
                ),
              ),
              BestLessProductButtons(
                  graphicsProvider: graphicsProvider, bodyLarge: bodyLarge),
              LastOrdersButtons(
                  graphicsProvider: graphicsProvider, bodyLarge: bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class LastOrdersButtons extends StatelessWidget {
  const LastOrdersButtons({
    super.key,
    required this.graphicsProvider,
    required this.bodyLarge,
  });

  final GraphicsProvider graphicsProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
            color: graphicsProvider.currentNumOrders.abs() == 10
                ? Constants.secondaryColor
                : null,
            onPressed: () async {
              graphicsProvider.changeCurrentNumOrders(10);
            },
            child: Text('Últimos 10 pedidos',
                style: bodyLarge.copyWith(
                    color: graphicsProvider.currentNumOrders.abs() == 10
                        ? Colors.white
                        : Colors.black))),
        MaterialButton(
            color: graphicsProvider.currentNumOrders.abs() == 50
                ? Constants.secondaryColor
                : null,
            onPressed: () async {
              graphicsProvider.changeCurrentNumOrders(50);
            },
            child: Text('Últimos 50 pedidos',
                style: bodyLarge.copyWith(
                    color: graphicsProvider.currentNumOrders.abs() == 50
                        ? Colors.white
                        : Colors.black))),
        MaterialButton(
          color: graphicsProvider.currentNumOrders.abs() == 100
              ? Constants.secondaryColor
              : null,
          onPressed: () async {
            graphicsProvider.changeCurrentNumOrders(100);
          },
          child: Text('Últimos 100 pedidos',
              style: bodyLarge.copyWith(
                  color: graphicsProvider.currentNumOrders.abs() == 100
                      ? Colors.white
                      : Colors.black)),
        )
      ],
    );
  }
}

class BestLessProductButtons extends StatelessWidget {
  const BestLessProductButtons({
    super.key,
    required this.graphicsProvider,
    required this.bodyLarge,
  });

  final GraphicsProvider graphicsProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
            color: graphicsProvider.isBestSelected
                ? Constants.secondaryColor
                : null,
            onPressed: () {
              graphicsProvider.changeIsBestSelected(true);
            },
            child: Text('Productos más vendidos',
                style: bodyLarge.copyWith(
                    color: graphicsProvider.isBestSelected
                        ? Colors.white
                        : Colors.black))),
        MaterialButton(
            color: !graphicsProvider.isBestSelected
                ? Constants.secondaryColor
                : null,
            onPressed: () {
              graphicsProvider.changeIsBestSelected(false);
            },
            child: Text('Productos menos vendidos',
                style: bodyLarge.copyWith(
                    color: !graphicsProvider.isBestSelected
                        ? Colors.white
                        : Colors.black))),
      ],
    );
  }
}
