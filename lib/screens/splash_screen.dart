import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wyb_ds/wyb_ds.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        GoRouter.of(context).go(GoRouterConstants.homeScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(WYBImages.iconImageName),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
