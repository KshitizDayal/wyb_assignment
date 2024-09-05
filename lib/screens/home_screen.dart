import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wyb_ds/wyb_ds.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PrimaryButton(
            buttonText: "Show Stories",
            onTap: () {
              GoRouter.of(context).push(GoRouterConstants.storiesScreen);
            },
          ),
        ],
      ),
    );
  }
}
