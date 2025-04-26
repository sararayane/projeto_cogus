import 'package:flutter/material.dart';
import '../utils/index.dart';
import 'app_logo.dart';

class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final double barHeight;

  final double logoSize;

  const AppHeaderBar({
    super.key,
    required this.onBack,
    this.barHeight = 80,
    this.logoSize = 100,
  });

  final VoidCallback onBack;

  @override
  Size get preferredSize => Size.fromHeight(barHeight + logoSize);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: barHeight,
          color: AppColors.primaryRed,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SafeArea(
            bottom: false,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: onBack,
              ),
            ),
          ),
        ),

        SizedBox(
          height: logoSize,
          child: Center(child: AppLogo(size: logoSize)),
        ),
      ],
    );
  }
}
