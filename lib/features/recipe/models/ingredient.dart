class Ingredient {
  final String name;
  final String? quantity;

  Ingredient({
    required this.name,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
    );
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? '',
    );
  }
}
