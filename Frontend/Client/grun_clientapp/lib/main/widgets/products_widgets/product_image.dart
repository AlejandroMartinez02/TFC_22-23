import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'product_count.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.photo,
    this.id,
  });

  final String? photo;
  final String? id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.4,
      child: Stack(children: [
        Hero(
          tag: id!,
          child: CachedNetworkImage(
              width: size.width,
              height: size.height * 0.4,
              imageUrl: photo!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Image(
                    image: Constants.foodLoader,
                    fit: BoxFit.cover,
                  ),
              errorWidget: (context, url, error) {
                return const Image(
                  image: Constants.noImage,
                  fit: BoxFit.cover,
                );
              }),
        ),
        BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.3),
              child: const ProductCount(),
            )),
      ]),
    );
  }
}
