import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grun_mobileapp/models/Response/products_dto.dart';

class ProductSwiper extends StatelessWidget {
  final List<ProductDTO> products;

  const ProductSwiper({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 80),
      child: CarouselSlider.builder(
          options: CarouselOptions(
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              autoPlayInterval: const Duration(seconds: 5)),
          itemCount: products.length,
          itemBuilder: (_, index, __) {
            return FadeInImage(
              image: NetworkImage(products[index].photo),
              placeholder: AssetImage("assets/foodLoader.gif"),
            );
          }),
    );
  }
}
