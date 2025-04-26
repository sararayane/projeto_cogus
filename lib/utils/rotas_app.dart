import 'package:flutter/material.dart';
import '../screens/screens.dart';

class Rotas {
  static const home = '/home';
  static const addProduct = '/add-product';
  static const addSupplier = '/add-supplier';
  static const stockMovement = '/stock-movement';
  static const viewStock = '/view-stock';
  static const viewSuppliers = '/view-suppliers';

  static final map = <String, WidgetBuilder>{
    home: (_) => const HomeScreen(),
    addProduct: (_) => const AdicionarProduto(),
    addSupplier: (_) => const AdicionarFornecedor(),
    stockMovement: (_) => const EntradaeSaidadeProduto(),
    viewStock: (_) => const VisualizacaodeProduto(),
    viewSuppliers: (_) => const VisualizacaodeFornecedor(),
  };

  static Future<void> go(BuildContext ctx, String route) =>
      Navigator.pushNamed(ctx, route);
}
