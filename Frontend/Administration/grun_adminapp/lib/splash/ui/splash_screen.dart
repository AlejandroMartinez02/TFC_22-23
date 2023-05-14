import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grun_adminapp/main/ui/main_screen.dart';
import 'package:provider/provider.dart';

import '../../login/ui/login_screen.dart';
import '../../utils/constants.dart';
import '../../utils/widgets/create_route.dart';
import 'splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  late Animation<double> opacity;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5600),
    );

    scale = Tween(begin: 0.0, end: 0.6)
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut)));

    controller.addListener(() async {
      final splashProvider =
          Provider.of<SplashProvider>(context, listen: false);
      if (controller.status == AnimationStatus.completed) {
        if (await splashProvider.getToken() != '') {
          if (await splashProvider.checkToken()) {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacement(
                  context,
                  CreateRoutes.slideFadeIn(
                      direccion: const Offset(1, 0),
                      screen: const MainScreen()));
            });
            return;
          } else {
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushReplacement(
                  context,
                  CreateRoutes.slideFadeIn(
                      direccion: const Offset(1, 0),
                      screen: LoginScreen(
                        isLogout: true,
                        message: Constants.logoutAutoMessage,
                      )));
            });
            return;
          }
        }
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
              context,
              CreateRoutes.slideFadeIn(
                  direccion: const Offset(1, 0), screen: LoginScreen()));
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;

    controller.forward();
    return Container(
      color: Colors.white,
      child: AnimatedBuilder(
        animation: controller,
        child: Scaffold(
            body: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: _splashContent(
                    size: size,
                    controller: controller,
                    primaryColor: primaryColor))),
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: opacity.value,
            child: Transform.scale(scale: scale.value, child: child),
          );
        },
      ),
    );
  }
}

class _splashContent extends StatelessWidget {
  const _splashContent({
    required this.size,
    required this.controller,
    required this.primaryColor,
  });

  final Size size;
  final AnimationController controller;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage("assets/light_logo.png")),
        SizedBox(
          height: size.height * 0.05,
        ),
        FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: controller,
              curve: const Interval(0.5, 0.8, curve: Curves.easeInExpo))),
          child: const Text(Constants.slogan,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Paralucent',
                fontWeight: FontWeight.bold,
                color: Constants.secondaryColor,
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
          child: CircularProgressIndicator(
              color: splashProvider.isLoading
                  ? Constants.secondaryColor
                  : Colors.white),
        )
      ],
    );
  }
}
