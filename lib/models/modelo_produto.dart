class Product {
  Product({
    this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    required this.desc,
  });

  final int? id;
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String desc;

  Product copyWith({
    int? id,
    String? name,
    String? category,
    int? quantity,
    double? price,
    String? desc,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'category': category,
    'quantity': quantity,
    'price': price,
    'desc': desc,
  };

  factory Product.fromMap(Map<String, dynamic> m) => Product(
    id: m['id'] as int?,
    name: m['name'] as String,
    category: m['category'] as String,
    quantity: m['quantity'] as int,
    price: (m['price'] as num).toDouble(),
    desc: m['desc'] as String,
  );
}
