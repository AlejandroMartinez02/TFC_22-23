import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../exports/main_pages.dart';
import '../../utils/widgets/bottom_bar.dart';
import '../../utils/widgets/loading_screen.dart';
import '../widgets/floating_button.dart';
import 'main_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    if (mainProvider.isLoading) return const LoadingScreen();
    return Scaffold(
        floatingActionButton:
            mainProvider.faIsVisible ? const CustomFloatingButton() : null,
        backgroundColor: const Color.fromARGB(237, 255, 255, 255),
        drawerEnableOpenDragGesture: false,
        bottomNavigationBar: const CustomBottomBar(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: mainProvider.pageController,
          children: const [
            HomePage(),
            MenuPage(),
            ProfilePage(),
          ],
        ));
  }
}
