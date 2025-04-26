import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 110});
  final double size;

  @override
  Widget build(BuildContext context) => 
    Image.asset('assets/logo.png', width: size);
}