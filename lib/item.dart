class Item {
  late String id, name;
  late double price, stock;

  Item({required this.id, required this.name, required this.price, required this.stock});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'price': price,
      'name': name,
      'stock': stock,
    };
    return map;
  }

  Item.fromMap(Map<String, Object?> map) {
    id = map['id'] as String;
    name = map['name'] as String;
    price = map['price'] as double;
    stock = map['stock'] as double;
  }
}
