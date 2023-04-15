// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/utils/utils.dart';

class CategoryCard extends StatelessWidget {
  final String photo;
  const CategoryCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 100,
        decoration: _cardDecoration(),
        child: Stack(children: [
          _backgroundImage(photo: photo),
          const _backgroundColor(),
          _cardTitle(
            title: photo.split('.')[0],
          )
        ]),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 2))
        ],
        color: Colors.white);
  }
}

class _cardTitle extends StatelessWidget {
  final String title;

  const _cardTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(20),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }
}

class _backgroundColor extends StatelessWidget {
  const _backgroundColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(156, 156, 156, 0.6),
                Color.fromRGBO(69, 69, 69, 1),
              ])),
    );
  }
}

class _backgroundImage extends StatelessWidget {
  final String photo;
  const _backgroundImage({
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      child: SizedBox(
          width: double.infinity,
          height: 350,
          child: FadeInImage(
            image: AssetImage("assets/$photo"),
            placeholder: const AssetImage("assets/foodLoader.gif"),
            fit: BoxFit.cover,
          )),
    );
  }
}
