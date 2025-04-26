import '../models/modelo_produto.dart';
import '../models/modelo_fornecedores.dart';

class Repository {
  Repository._();
  static final instance = Repository._();

  final List<Product> _products = <Product>[];
  final List<Fornecedor> _suppliers = <Fornecedor>[];

  Future<void> addProduct(Product product) async {
    final idx = _products.indexWhere((p) => p.id == product.id);
    if (idx >= 0) {
      _products[idx] = product;
    } else {
      _products.add(product);
    }
  }

  Future<List<Product>> fetchProducts() async {
    return List<Product>.unmodifiable(_products);
  }

  Future<void> addSupplier(Fornecedor supplier) async {
    final idx = _suppliers.indexWhere((s) => s.id == supplier.id);
    if (idx >= 0) {
      _suppliers[idx] = supplier;
    } else {
      _suppliers.add(supplier);
    }
  }

  Future<List<Fornecedor>> fetchSuppliers() async {
    return List<Fornecedor>.unmodifiable(_suppliers);
  }
}
