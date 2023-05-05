import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/providers.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    final menuProvider = Provider.of<MenuProvider>(context);

    final primaryColor = Theme.of(context).primaryColor;

    return BottomNavigationBar(
      onTap: (i) => mainProvider.changeActualPage(i, menuProvider),
      currentIndex: mainProvider.actualPage,
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
