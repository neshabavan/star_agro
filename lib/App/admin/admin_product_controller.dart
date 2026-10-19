
import 'package:flutter/material.dart';
import '../../utility/product_model.dart';
import '../../utility/product_database.dart';

class AdminProductController extends ChangeNotifier {
  // Products save karne ke liye database.
  final ProductDatabase productDatabase = ProductDatabase();

  // Products ki list.
  List<ProductModel> products = [];

  // Loading indicator.
  bool isLoading = false;

  // Database se products load karna.
  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      products = await productDatabase.getProducts();
    } catch (error) {
      debugPrint('Products load error: $error');
    }

    isLoading = false;
    notifyListeners();
  }

  // Naya product add karna.
  Future<void> addProduct({
    required String name,
    required String category,
    required String description,
    required String imagePath,
  }) async {
    final ProductModel product = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      category: category,
      description: description,
      imagePath: imagePath,
    );

    await productDatabase.addProduct(product);
    await loadProducts();
  }

  // Existing product edit karna.
  Future<void> updateProduct({
    required String id,
    required String name,
    required String category,
    required String description,
    required String imagePath,
  }) async {
    final ProductModel updatedProduct = ProductModel(
      id: id,
      name: name,
      category: category,
      description: description,
      imagePath: imagePath,
    );

    await productDatabase.updateProduct(updatedProduct);
    await loadProducts();
  }

  // Product delete karna.
  Future<void> deleteProduct(String id) async {
    await productDatabase.deleteProduct(id);
    await loadProducts();
  }
}
