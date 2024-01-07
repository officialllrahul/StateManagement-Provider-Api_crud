class Item {
  final String id;
  final String name;
  final double price;

  Item({required this.id, required this.name, required this.price});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}