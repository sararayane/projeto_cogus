import 'package:flutter/material.dart';
import '../utils/index.dart';

class AumentarDiminuir extends StatelessWidget {
  const AumentarDiminuir({super.key, required this.onInc, required this.onDec});

  final VoidCallback onInc;
  final VoidCallback onDec;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      _circle(icon: Icons.add, onTap: onInc),
      const SizedBox(width: 12),
      _circle(icon: Icons.remove, onTap: onDec),
    ],
  );

  Widget _circle({required IconData icon, required VoidCallback onTap}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderBrown, width: 3),
          ),
          child: Icon(icon, size: 20, color: AppColors.borderBrown),
        ),
      );
}
