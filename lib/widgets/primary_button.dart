import 'package:flutter/material.dart';
import '../utils/index.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  static final theme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      minimumSize: Size(double.infinity, Dimensoes.buttonH),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensoes.radiusXL),
        side: const BorderSide(color: AppColors.borderBrown, width: 3),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onTap,
    child: Text(label, textAlign: TextAlign.center),
  );
}
