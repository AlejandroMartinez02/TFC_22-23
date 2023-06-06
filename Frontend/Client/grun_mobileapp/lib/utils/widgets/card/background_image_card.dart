import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class BackgroundImage extends StatelessWidget {
  final String photo;
  const BackgroundImage({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: photo,
            placeholder: (_, __) => const Image(
                  image: Constants.foodLoader,
                  fit: BoxFit.cover,
                ),
            errorWidget: (context, url, error) => const Image(
                  image: Constants.noImage,
                  fit: BoxFit.cover,
                )),
      ),
    );
  }
}
