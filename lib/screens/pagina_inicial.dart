import 'package:flutter/material.dart';
import 'package:projetointegrador2025/widgets/app_logo.dart';
import 'package:projetointegrador2025/widgets/primary_button.dart';
import '../utils/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(),
            const SizedBox(height: 28),
            Text(
              S.welcome,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: S.addProduct,
              onTap: () => Rotas.go(context, Rotas.addProduct),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: S.addSupplier,
              onTap: () => Rotas.go(context, Rotas.addSupplier),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: S.stockMovement,
              onTap: () => Rotas.go(context, Rotas.stockMovement),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: S.viewStock,
              onTap: () => Rotas.go(context, Rotas.viewStock),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: S.viewSuppliers,
              onTap: () => Rotas.go(context, Rotas.viewSuppliers),
            ),
          ],
        ),
      ),
    ),
  );
}
