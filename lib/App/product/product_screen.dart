
import 'package:flutter/material.dart';
import '../../utility/product_model.dart';
import '../../utility/product_database.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // Database se products save aur load karne ke liye.
  final ProductDatabase productDatabase = ProductDatabase();

  // Selected category.
  String selectedCategory = 'All';

  // Database se milne wale products.
  List<ProductModel> products = [];

  // Loading indicator ke liye.
  bool isLoading = true;

  // Website par dikhne wali categories.
  final List<String> categories = [
    'All',
    'Seeds',
    'Fertilizers',
    'Crop Care',
    
  ];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  // Database se products load karna.
  Future<void> loadProducts() async {
    try {
      List<ProductModel> savedProducts =
          await productDatabase.getProducts();

      // Pehli baar database empty ho to sample products save honge.
      if (savedProducts.isEmpty) {
        savedProducts = [
          ProductModel(
            id: '1',
            name: 'Quality Seeds',
            category: 'Seeds',
            description: 'Seeds for your agricultural needs.',
            imagePath: 'assets/images/seeds.jpg',
          ),
          ProductModel(
            id: '2',
            name: 'Organic Fertilizer',
            category: 'Fertilizers',
            description: 'Fertilizer products for farm use.',
            imagePath: 'assets/images/fertilizers.jpg',
          ),
          ProductModel(
            id: '3',
            name: 'Crop Care',
            category: 'Crop Care',
            description: 'Products for crop maintenance.',
            imagePath: 'assets/images/crop_care.jpg',
          ),
         
        ];

        await productDatabase.saveProducts(savedProducts);
      }

      if (!mounted) return;

      setState(() {
        products = savedProducts;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Products load nahi ho sake.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Selected category ke according products filter honge.
    final List<ProductModel> filteredProducts =
        selectedCategory == 'All'
            ? products
            : products
                .where(
                  (product) =>
                      product.category == selectedCategory,
                )
                .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F2),

      // Page header.
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.agriculture, size: 28),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'Star Agro - Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      // Loading, empty ya products ki list.
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2E7D32),
              ),
            )
          : RefreshIndicator(
              onRefresh: loadProducts,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome banner.
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF2E7D32),
                            Color(0xFF1B5E20),
                          ],
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Our Products',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Explore agricultural products for your farm.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'તમારા ખેતર માટે કૃષિ ઉત્પાદનો',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'आपके खेत के लिए कृषि उत्पाद',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Category heading.
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 28, 20, 12),
                      child: Text(
                        'Browse Categories',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                    ),

                    // Category filters.
                    SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        children: categories.map((category) {
                          final bool isSelected =
                              selectedCategory == category;

                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
                              selectedColor: const Color(0xFF2E7D32),
                              backgroundColor: Colors.white,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF1B5E20),
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // Product count.
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20, 24, 20, 16,
                      ),
                      child: Text(
                        'Showing ${filteredProducts.length} products',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),

                    // Products display.
                    if (filteredProducts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            'No products found in this category.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int columnCount = 1;

                            if (constraints.maxWidth >= 1000) {
                              columnCount = 4;
                            } else if (constraints.maxWidth >= 600) {
                              columnCount = 2;
                            }

                            const double spacing = 16;

                            final double cardWidth =
                                (constraints.maxWidth -
                                    spacing * (columnCount - 1)) /
                                columnCount;

                            return Wrap(
                              spacing: spacing,
                              runSpacing: spacing,
                              children: filteredProducts.map((product) {
                                return SizedBox(
                                  width: cardWidth,
                                  child: productCard(product),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),

                    // Bottom information section.
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 32),
                      padding: const EdgeInsets.all(24),
                      color: const Color(0xFFE3EEDC),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need help choosing a product?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Contact Star Agro for product information.',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Ek product ka card.
  Widget productCard(ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD5E4CF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Abhi bundled asset ya online image path support hota hai.
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child:  product.imagePath.startsWith('http')
                ? Image.network(
                    product.imagePath,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return imagePlaceholder();
                    },
                  )
                : Image.asset(
                    product.imagePath,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return imagePlaceholder();
                    },
                  ),
          ),

          // Product details.
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category,
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Image load na ho to placeholder dikhana.
  Widget imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 180,
      color: const Color(0xFFE8F5E9),
      child: const Icon(
        Icons.agriculture,
        size: 55,
        color: Color(0xFF2E7D32),
      ),
    );
  }
}
