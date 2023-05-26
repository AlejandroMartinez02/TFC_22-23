import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utils/constants.dart';
import '../domain/entities/product_graphics_dto.dart';
import 'package:flutter/material.dart';

import '../ui/graphics_provider.dart';

class CircularChart extends StatelessWidget {
  const CircularChart({
    super.key,
    required this.graphicsProvider,
    required this.bodyLarge,
  });

  final GraphicsProvider graphicsProvider;
  final TextStyle bodyLarge;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
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
          legendItemBuilder:
              (String name, dynamic series, dynamic point, int index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    color: (point as ChartPoint).color, height: 10, width: 10),
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
            dataSource: graphicsProvider
                .numProducts[graphicsProvider.currentNumOrders.toString()],
            dataLabelMapper: (ProductGraphicsDTO data, index) =>
                data.count.toString(),
            xValueMapper: (ProductGraphicsDTO data, _) => data.product.name,
            yValueMapper: (ProductGraphicsDTO data, _) => data.count,
            dataLabelSettings:
                DataLabelSettings(isVisible: true, textStyle: bodyLarge))
      ],
    );
  }
}
