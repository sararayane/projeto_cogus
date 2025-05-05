class Fornecedor {
  Fornecedor({
    this.id,
    required this.name,
    required this.product,
    required this.desc,
  });

  final int? id;
  final String name;
  final String product;
  final String desc;

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'product': product,
    'desc': desc,
  };

  factory Fornecedor.fromMap(Map<String, dynamic> m) => Fornecedor(
    id: m['id'] as int?,
    name: m['name'] as String,
    product: m['product'] as String,
    desc: m['desc'] as String,
  );
}
