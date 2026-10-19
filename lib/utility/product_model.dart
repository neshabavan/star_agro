
class ProductModel {
  // Product ki basic information
  String id;
  String name;
  String category;
  String description;
  String imagePath;

  // Constructor
  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imagePath,
  });

  // Product ko Map mein convert karna
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imagePath': imagePath,
    };
  }

  // Map se ProductModel banana
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      imagePath: map['imagePath'] ?? '',
    );
  }
}
