import 'package:flutter/material.dart';
import 'package:wyb_ds/constants/wyb_color.dart';
import 'package:wyb_ds/constants/wyb_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const PrimaryButton(
      {super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              WybColor.secondary,
              WybColor.tertiary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          ),
          child: Text(
            buttonText,
            style: WybFonts.normal14.copyWith(color: WybColor.black),
          ),
        ),
      ),
    );
  }
}
