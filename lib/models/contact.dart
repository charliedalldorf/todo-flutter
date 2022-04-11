class Contact {
  final int id;
  final String name;
  final String phone;

  const Contact({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'phone': phone};
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, phone: $phone}';
  }
}
