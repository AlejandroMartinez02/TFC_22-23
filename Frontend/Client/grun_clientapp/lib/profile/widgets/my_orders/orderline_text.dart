import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../data/network/response/order_line_dto.dart';

// ignore: must_be_immutable
class OrderLinesWidget extends StatelessWidget {
  OrderLinesWidget({super.key, required this.orderLines});

  List<OrderLineDTO> orderLines;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bodyLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: size.width < 600 ? 16 : 18);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: orderLines.length < 3 ? orderLines.length : 3,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: size.width * 0.6,
                      maxHeight: size.height * 0.03),
                  child: AutoSizeText(
                    '${orderLines[index].product.name} x ${orderLines[index].count}',
                    style: bodyLarge,
                    minFontSize: size.width < 600 ? 18 : 20,
                    maxLines: 1,
                    overflowReplacement: Marquee(
                      text:
                          '${orderLines[index].product.name} x ${orderLines[index].count}',
                      style: bodyLarge.copyWith(
                        fontSize: size.width < 600 ? 18 : 20,
                      ),
                      crossAxisAlignment: CrossAxisAlignment.end,
                      pauseAfterRound: const Duration(seconds: 2),
                      startPadding: 10.0,
                      blankSpace: 22,
                      accelerationDuration: const Duration(seconds: 1),
                      accelerationCurve: Curves.easeInCubic,
                      decelerationDuration: const Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOutCubic,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AutoSizeText(
                  '${orderLines[index].cost}€',
                  style: bodyLarge,
                  minFontSize: size.width < 600 ? 18 : 20,
                ),
              ],
            );
          },
        ),
        if (orderLines.length > 3)
          Text(
            '...',
            style: bodyLarge.copyWith(fontSize: size.width < 600 ? 20 : 22),
          )
      ],
    );
  }
}
