import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../exports/providers.dart';
import '../../exports/screens.dart';

import '../../utils/constants.dart';
import '../../utils/services/navigator_service.dart';
import '../../utils/widgets/custom_app_bar.dart';
import '../widgets/logout_dialog_android.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Platform.isLinux || Platform.isMacOS || Platform.isWindows
                ? const CustomAppBar()
                : Container(),
            Expanded(
                child: Row(
              children: [
                LeftMenu(size: size),
                Expanded(
                  child: Container(
                    child: mainProvider.currentPage,
                  ),
                )
              ],
            )),
          ],
        ));
  }
}

class LeftMenu extends StatelessWidget {
  const LeftMenu({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Constants.secondaryColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Constants.borderRadius),
              bottomRight: Radius.circular(Constants.borderRadius))),
      width: size.width * 0.2,
      child: SizedBox(
        height: size.height,
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              margin: EdgeInsets.only(top: size.height * 0.02),
              child: Icon(
                Icons.admin_panel_settings_rounded,
                size: size.height * 0.15,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * 0.55,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    UserOptions(size: size),
                    DishOption(size: size),
                    CategoryOption(size: size),
                    WorkerOption(size: size),
                    OrderOption(size: size),
                    TableOption(size: size),
                    GraphicsOption(size: size)
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: size.height * 0.02),
                child: LogOutOption(size: size))
          ],
        ),
      ),
    );
  }
}

class UserOptions extends StatelessWidget {
  const UserOptions({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    return GestureDetector(
      onTap: () async {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        mainProvider.changePage(const UsersScreen());
        userProvider.loadData();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
            border:
                Border.symmetric(horizontal: BorderSide(color: Colors.white))),
        child: Row(
          children: [
            Image(
              image: const AssetImage("assets/user.png"),
              color: Colors.white,
              height: size.height * 0.04,
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            AutoSizeText(
              Constants.users,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class DishOption extends StatelessWidget {
  const DishOption({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () async {
        final dishProvider = Provider.of<DishProvider>(context, listen: false);
        mainProvider.changePage(const DishScreen());
        await dishProvider.loadData();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(
          children: [
            Image(
              image: const AssetImage("assets/dish.png"),
              height: size.height * 0.04,
              color: Colors.white,
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            AutoSizeText(
              Constants.dishes,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryOption extends StatelessWidget {
  const CategoryOption({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    return GestureDetector(
      onTap: () async {
        final categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        mainProvider.changePage(const CategoryScreen());
        await categoryProvider.loadData();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(children: [
          Image(
            image: const AssetImage("assets/menu.png"),
            height: size.height * 0.04,
            color: Colors.white,
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          AutoSizeText(
            Constants.categories,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}

class WorkerOption extends StatelessWidget {
  const WorkerOption({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () async {
        final workerProvider =
            Provider.of<WorkerProvider>(context, listen: false);
        mainProvider.changePage(const WorkerScreen());
        await workerProvider.loadData();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(children: [
          Image(
            image: const AssetImage("assets/worker.png"),
            height: size.height * 0.04,
            color: Colors.white,
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          AutoSizeText(
            Constants.workers,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}

class OrderOption extends StatelessWidget {
  const OrderOption({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () async {
        final orderProvider =
            Provider.of<OrderProvider>(context, listen: false);
        mainProvider.changePage(const OrderScreen());
        await orderProvider.loadData();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(children: [
          Image(
            image: const AssetImage("assets/order.png"),
            height: size.height * 0.04,
            color: Colors.white,
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          AutoSizeText(
            Constants.orders,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}

class GraphicsOption extends StatelessWidget {
  const GraphicsOption({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () async {
        final graphicsProvider =
            Provider.of<GraphicsProvider>(context, listen: false);
        mainProvider.changePage(const GraphicsScreen());
        await graphicsProvider.loadBestData();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(children: [
          Image(
            image: const AssetImage("assets/graphic.png"),
            height: size.height * 0.04,
            color: Colors.white,
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          AutoSizeText(
            Constants.graphics,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}

class TableOption extends StatelessWidget {
  const TableOption({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () async {
        final tableProvider =
            Provider.of<TableProvider>(context, listen: false);
        mainProvider.changePage(const TableScreen());
        await tableProvider.loadData();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.02),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(children: [
          Image(
            image: const AssetImage("assets/table.png"),
            height: size.height * 0.04,
            color: Colors.white,
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          AutoSizeText(
            Constants.tables,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}

class LogOutOption extends StatelessWidget {
  const LogOutOption({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showResponse();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.height * 0.02),
        child: Row(children: [
          const Icon(
            Icons.login_outlined,
            color: Colors.red,
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          AutoSizeText(
            Constants.logout,
            maxFontSize: 18,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}

void _showResponse() {
  showDialog(
      context: NavigatorService.navigatorKey.currentContext!,
      builder: (context) {
        return const LogoutDialogAndroid();
      });
}
