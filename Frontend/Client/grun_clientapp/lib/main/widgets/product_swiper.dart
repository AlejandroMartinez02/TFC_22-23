import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../domain/entity/products_dto.dart';
import 'main_widgets.dart';

class ProductSwiper extends StatelessWidget {
  final List<ProductDTO> products;

  const ProductSwiper({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return products.isEmpty
        ? Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            alignment: Alignment.center,
            height: size.height * 0.3,
            child: Text(
              Constants.noProducts,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black),
            ),
          )
        : Container(
            margin: EdgeInsets.only(
                top: size.height * 0.1, bottom: size.height * 0.05),
            child: CarouselSlider.builder(
                options: CarouselOptions(
                    viewportFraction: size.width < 600 ? 0.80 : 0.55,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 2500),
                    autoPlayInterval: const Duration(seconds: 5)),
                itemCount: products.length,
                itemBuilder: (_, index, __) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ProductCard(product: products[index]),
                  );
                }),
          );
  }
}
