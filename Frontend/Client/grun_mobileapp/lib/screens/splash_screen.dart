import 'package:flutter/material.dart';
import 'package:grun_mobileapp/providers/login_form_provider.dart';
import 'package:grun_mobileapp/screens/home_screen.dart';
import 'package:grun_mobileapp/screens/login_screen.dart';
import 'package:grun_mobileapp/utils/utils.dart';
import 'package:provider/provider.dart';

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
  late LoginFormProvider repo;

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
      if (controller.status == AnimationStatus.completed) {
        if (await repo.readToken() == '') {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              CreateRoutes.SlideFadeIn(
                  direccion: const Offset(1, 0), screen: const LoginScreen()));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              CreateRoutes.SlideFadeIn(
                  direccion: const Offset(1, 0), screen: const HomeScreen()));
        }
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
    repo = Provider.of<LoginFormProvider>(context);

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
                child: _contentSplash(size, primaryColor))),
        builder: (BuildContext context, Widget? child) {
          return Opacity(
            opacity: opacity.value,
            child: Transform.scale(scale: scale.value, child: child),
          );
        },
      ),
    );
  }

  Column _contentSplash(Size size, Color primaryColor) {
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
          child: Text(Constants.slogan,
              style: TextStyle(
                fontSize: size.width * 0.1,
                fontFamily: 'Paralucent',
                fontWeight: FontWeight.bold,
                color: primaryColor,
              )),
        )
      ],
    );
  }
}
