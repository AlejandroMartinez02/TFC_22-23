import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BottomNavigationBar(
      currentIndex: 0,
      backgroundColor: primaryColor,
      unselectedItemColor: Colors.grey[600],
      fixedColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
            label: "Inicio",
            icon: Icon(
              Icons.home,
            )),
        BottomNavigationBarItem(
            label: "Menú",
            icon: Icon(
              Icons.restaurant_menu,
            )),
        BottomNavigationBarItem(
            label: "Perfil",
            icon: Icon(
              Icons.person,
            ))
      ],
    );
  }
}
