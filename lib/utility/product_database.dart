
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'product_model.dart';

class ProductDatabase {
  // Browser mein products save karne ke liye key
  static const String _productKey = 'star_agro_products';

  // Saare products read karna
  Future<List<ProductModel>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();

    final String? productData = prefs.getString(_productKey);

    if (productData == null || productData.isEmpty) {
      return [];
    }

    final List<dynamic> decodedData = jsonDecode(productData);

    return decodedData.map((item) {
      return ProductModel.fromMap(
        Map<String, dynamic>.from(item),
      );
    }).toList();
  }

  // Saare products save karna
  Future<void> saveProducts(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();

    final String encodedData = jsonEncode(
      products.map((product) => product.toMap()).toList(),
    );

    await prefs.setString(_productKey, encodedData);
  }

  // Naya product add karna
  Future<void> addProduct(ProductModel product) async {
    final products = await getProducts();

    products.add(product);

    await saveProducts(products);
  }

  // Product edit karna
  Future<void> updateProduct(ProductModel updatedProduct) async {
    final products = await getProducts();

    final index = products.indexWhere(
      (product) => product.id == updatedProduct.id,
    );

    if (index != -1) {
      products[index] = updatedProduct;
      await saveProducts(products);
    }
  }

  // Product delete karna
  Future<void> deleteProduct(String id) async {
    final products = await getProducts();

    products.removeWhere((product) => product.id == id);

    await saveProducts(products);
  }
}
