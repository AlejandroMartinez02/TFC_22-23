import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../../../utils/constants.dart';
import '../../../data/network/response/order_line_dto.dart';

class OrderLineDetails extends StatelessWidget {
  const OrderLineDetails({super.key, required this.orderLine});

  final OrderLineDTO orderLine;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: size.height * 0.01),
      padding: EdgeInsets.symmetric(horizontal: size.height * 0.01),
      height: size.height * 0.2,
      width: size.width,
      child: Flex(direction: Axis.horizontal, children: [
        Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            _ProductPhoto(orderLine: orderLine, size: size),
            Expanded(
              child: Column(
                children: [
                  _TitlePrice(orderLine: orderLine, size: size),
                  _ProductDescription(orderLine: orderLine, size: size)
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({
    required this.orderLine,
    required this.size,
  });

  final OrderLineDTO orderLine;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final fontSize = size.width < 600 ? 18.0 : 20.0;
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ContainerDescription(
            child: AutoSizeText(
              orderLine.product.description,
              overflow: TextOverflow.ellipsis,
              maxFontSize: fontSize,
              minFontSize: fontSize,
              maxLines: 3,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: size.width < 600 ? 22 : 24,
                  ),
            ),
          ),
          Text('${orderLine.cost}€',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: size.width < 600 ? 22 : 24,
                  ))
        ],
      ),
    );
  }
}

class _TitlePrice extends StatelessWidget {
  const _TitlePrice({
    required this.orderLine,
    required this.size,
  });

  final OrderLineDTO orderLine;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ContainerTitle(
            child: AutoSizeText(orderLine.product.name,
                maxLines: 1,
                minFontSize: size.width < 600 ? 18 : 22,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: size.width < 600 ? 22 : 24,
                    ),
                overflowReplacement: Marquee(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  pauseAfterRound: const Duration(seconds: 2),
                  startPadding: 18.0,
                  blankSpace: size.width < 600 ? 14 : 18,
                  accelerationDuration: const Duration(seconds: 1),
                  accelerationCurve: Curves.easeInCubic,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOutCubic,
                  text: orderLine.product.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: size.width < 600 ? 22 : 24,
                      ),
                )),
          ),
          Text(
            "x${orderLine.count}",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: size.width < 600 ? 22 : 24,
                ),
          )
        ],
      ),
    );
  }
}

class _ProductPhoto extends StatelessWidget {
  const _ProductPhoto({
    required this.orderLine,
    required this.size,
  });

  final OrderLineDTO orderLine;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '${orderLine.id}${orderLine.product.id}',
      child: CachedNetworkImage(
        height: size.height * 0.15,
        width: size.width * 0.25,
        imageUrl: orderLine.product.photo,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Image(
          image: Constants.foodLoader,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) =>
            const Image(image: Constants.noImage, fit: BoxFit.cover),
      ),
    );
  }
}

class _ContainerTitle extends StatelessWidget {
  const _ContainerTitle({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      padding: EdgeInsets.only(left: size.width * 0.02),
      constraints: BoxConstraints(
          maxHeight: size.width < 600 ? 22 : 30, maxWidth: size.width),
      child: child,
    );
  }
}

class _ContainerDescription extends StatelessWidget {
  const _ContainerDescription({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.5,
      padding: EdgeInsets.only(left: size.width * 0.02),
      constraints: BoxConstraints(maxWidth: size.width),
      child: child,
    );
  }
}
