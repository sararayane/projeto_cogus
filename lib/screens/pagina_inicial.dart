import 'package:flutter/material.dart';
import 'package:projetointegrador2025/widgets/app_logo.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import '../utils/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    double logoSize;
    double contentMaxWidth;
    double gapButtons;
    const double gapLogoText = 8;

    if (width <= 600) {
      // celulares
      logoSize = (width * 0.40).clamp(180, 300);
      contentMaxWidth = double.infinity;
      gapButtons = 20;
    } else if (width <= 960) {
      // tablets
      logoSize = (width * 0.30).clamp(200, 350);
      contentMaxWidth = 500;
      gapButtons = 24;
    } else {
      // desktops
      logoSize = (width * 0.25).clamp(220, 400);
      contentMaxWidth = 600;
      gapButtons = 28;
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppLogo(size: logoSize),
                const SizedBox(height: gapLogoText),

                Text(
                  S.welcome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width < 380 ? 20 : 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),

                PrimaryButton(
                  label: S.addProduct,
                  onTap: () => Rotas.go(context, Rotas.addProduct),
                ),
                SizedBox(height: gapButtons),
                PrimaryButton(
                  label: S.addSupplier,
                  onTap: () => Rotas.go(context, Rotas.addSupplier),
                ),
                SizedBox(height: gapButtons),
                PrimaryButton(
                  label: S.stockMovement,
                  onTap: () => Rotas.go(context, Rotas.stockMovement),
                ),
                SizedBox(height: gapButtons),
                PrimaryButton(
                  label: S.viewStock,
                  onTap: () => Rotas.go(context, Rotas.viewStock),
                ),
                SizedBox(height: gapButtons),
                PrimaryButton(
                  label: S.viewSuppliers,
                  onTap: () => Rotas.go(context, Rotas.viewSuppliers),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
