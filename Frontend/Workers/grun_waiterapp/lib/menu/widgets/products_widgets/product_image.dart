import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        GestureDetector(
          onTap: () => {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 2.0,
                      child: CachedNetworkImage(
                          imageUrl: photo!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image.asset(
                                "assets/foodLoader.gif",
                                fit: BoxFit.cover,
                              ),
                          errorWidget: (context, url, error) {
                            return const Image(
                              image: AssetImage("assets/no-image.png"),
                              fit: BoxFit.cover,
                            );
                          }),
                    ),
                    // actions: [
                    //   MaterialButton(
                    //     onPressed: () => Navigator.pop(context),
                    //     child: Text(
                    //       Constants.turnBack,
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyLarge!
                    //           .copyWith(color: Constants.secondaryColor),
                    //     ),
                    //   )
                    // ],
                  );
                })
          },
          child: Hero(
            tag: id!,
            child: CachedNetworkImage(
                width: size.width,
                height: size.height * 0.4,
                imageUrl: photo!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                      "assets/foodLoader.gif",
                      fit: BoxFit.cover,
                    ),
                errorWidget: (context, url, error) {
                  return const Image(
                    image: AssetImage("assets/no-image.png"),
                    fit: BoxFit.cover,
                  );
                }),
          ),
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
