class Fornecedor {
  Fornecedor({
    this.id,
    required this.name,
    required this.product,
    required this.quantity,
    required this.desc,
  });

  final int? id;
  final String name;
  final String product;
  final int quantity;
  final String desc;

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'product': product,
    'quantity': quantity,
    'desc': desc,
  };

  factory Fornecedor.fromMap(Map<String, dynamic> m) => Fornecedor(
    id: m['id'] as int?,
    name: m['name'] as String,
    product: m['product'] as String,
    quantity: m['quantity'] as int,
    desc: m['desc'] as String,
  );
}
