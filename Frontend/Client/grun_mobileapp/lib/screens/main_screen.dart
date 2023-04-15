import 'package:flutter/material.dart';
import 'package:grun_mobileapp/widgets/main_widgets/main_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> photos = [
      "entrantes.jpg",
      "para_compartir.jpg",
      "bocadillos.jpg",
      "hamburguesas.jpeg",
      "postres.jpg",
      "bebidas.jpg"
    ];
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 237, 237),
        appBar: AppBar(
          title: const Text("Productos"),
        ),
        body: ListView.builder(
          itemCount: 6,
          itemBuilder: (_, int index) => CategoryCard(photo: photos[index]),
        ));
  }
}
