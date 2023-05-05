import 'package:flutter/material.dart';
import 'package:grun_mobileapp/exports/main_pages.dart';
import 'package:grun_mobileapp/exports/screens.dart';
import 'package:grun_mobileapp/main/ui/main_provider.dart';
import 'package:grun_mobileapp/main/widgets/main_widgets.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    if (mainProvider.isLoading) return const LoadingScreen();

    return Scaffold(
        backgroundColor: const Color.fromARGB(237, 255, 255, 255),
        drawerEnableOpenDragGesture: false,
        bottomNavigationBar: const CustomBottomBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
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
