class User {
  late String id, title, name;
  late String? address;
  late int age;

  User({required this.id, required this.title, required this.name, this.address, required this.age});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'id': id,
      'title': title,
      'name': name,
      'address': address,
      'age': age,
    };
    return map;
  }

  User.fromMap(Map<String, Object?> map) {
    id = map['id'] as String;
    title = map['title'] as String;
    name = map['name'] as String;
    age = map['age'] as int;
  }
}
