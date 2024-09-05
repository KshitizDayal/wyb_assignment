import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  final Widget child;
  const CustomColumn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
