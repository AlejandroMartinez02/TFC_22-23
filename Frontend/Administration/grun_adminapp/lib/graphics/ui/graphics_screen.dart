import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'graphics_provider.dart';

class GraphicsScreen extends StatelessWidget {
  const GraphicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyLarge =
        Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black);
    final size = MediaQuery.of(context).size;
    final graphicsProvider = Provider.of<GraphicsProvider>(context);
    if (graphicsProvider.isLoading) return const LoadingScreen();
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.7,
                margin: EdgeInsets.all(size.width * 0.02),
                child: CircularChart(
                    graphicsProvider: graphicsProvider, bodyLarge: bodyLarge),
              ),
              BestLessProductButtons(
                  graphicsProvider: graphicsProvider, bodyLarge: bodyLarge),
              LastOrdersButtons(
                  graphicsProvider: graphicsProvider, bodyLarge: bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}
