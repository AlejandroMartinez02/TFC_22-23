import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    return Stack(children: [
      Hero(
        tag: id!,
        child: CachedNetworkImage(
          width: size.width,
          height: size.height * 0.4,
          imageUrl: photo!,
          fit: BoxFit.cover,
        ),
      ),
      BackButton(
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
    ]);
  }
}
