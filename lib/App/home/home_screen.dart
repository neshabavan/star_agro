
import 'package:flutter/material.dart';
import 'package:star_agro/App/about/about_screen.dart';
import 'package:star_agro/App/admin/admin_login_screen.dart';
import 'package:star_agro/App/contact/contact_screen.dart';
import 'package:star_agro/App/product/product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F2),

      // Website ka header aur responsive navigation
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,

        // Shop ka logo aur naam
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.agriculture, size: 30),
            SizedBox(width: 10),
            Text(
              'Star Agro',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Screen width ke hisaab se menu badlega
        actions: [
          LayoutBuilder(
            builder: (context, constraints) {
              // Desktop par navigation buttons dikhayenge
              return
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    // Home page.
    TextButton(
      onPressed: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: const Text(
        'Home',
        style: TextStyle(color: Colors.white),
      ),
    ),

    // Products page.
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductScreen(),
          ),
        );
      },
      child: const Text(
        'Products',
        style: TextStyle(color: Colors.white),
      ),
    ),

    // About Us page.
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutScreen(),
          ),
        );
      },
      child: const Text(
        'About Us',
        style: TextStyle(color: Colors.white),
      ),
    ),

    // Contact page.
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactScreen(),
          ),
        );
      },
      child: const Text(
        'Contact',
        style: TextStyle(color: Colors.white),
      ),
    ),

    // Admin Login page.
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminLoginScreen(),
            ),
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF1B5E20),
        ),
        child: const Text('Admin Login'),
      ),
    ),
  ],
);

            },
          ),
        ],

        // Mobile menu ka button
        
        // Desktop par width zyada hone par menu button nahi chahiye
        // Isliye mobile navigation neeche alag responsive section mein hai.
      ),

      // Website ka main content
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mobile navigation
                if (constraints.maxWidth < 650)
                  _mobileNavigation(context),

                // Welcome banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    constraints.maxWidth < 600 ? 20 : 28,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2E7D32),
                        Color(0xFF1B5E20),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Star Agro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              constraints.maxWidth < 600 ? 25 : 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Your trusted partner in agriculture.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'ખેતી માટે વિશ્વાસપાત્ર સાથી',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'खेती के लिए आपका भरोसेमंद साथी',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories heading
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 28, 20, 16),
                  child: Text(
                    'Our Categories | અમારી શ્રેણીઓ | हमारी श्रेणियाँ',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                ),

                // Product categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _categoryCard(
                        Icons.grass,
                        'Seeds',
                        'બીજ | बीज',
                      ),
                      _categoryCard(
                        Icons.compost,
                        'Fertilizers',
                        'ખાતર | खाद',
                      ),
                      _categoryCard(
                        Icons.sanitizer,
                        'Crop Care',
                        'પાક સંભાળ | फसल देखभाल',
                      ),
                     
                    ],
                  ),
                ),

                // Featured Products heading
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 32, 20, 8),
                  child: Text(
                    'Featured Products | ખાસ ઉત્પાદનો | प्रमुख उत्पाद',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 18),
                  child: Text(
                    'Explore our agricultural products.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),

                // Responsive product cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int columnCount = 1;

                      if (constraints.maxWidth >= 900) {
                        columnCount = 4;
                      } else if (constraints.maxWidth >= 550) {
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
                        children: [
                          SizedBox(
                            width: cardWidth,
                            child: _productCard(
                              imagePath: 'assets/images/seeds.jpg',
                              productName: 'Quality Seeds',
                              category: 'Seeds',
                              description:
                                  'Seeds for your agricultural needs.',
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _productCard(
                              imagePath: 'assets/images/fertilizers.jpg',
                              productName: 'Organic Fertilizer',
                              category: 'Fertilizers',
                              description:
                                  'Fertilizer products for farm use.',
                            ),
                          ),
                          SizedBox(
                            width: cardWidth,
                            child: _productCard(
                              imagePath: 'assets/images/crop_care.jpg',
                              productName: 'Crop Care',
                              category: 'Crop Care',
                              description:
                                  'Products for crop maintenance.',
                            ),
                          ),
                        
                        ],
                      );
                    },
                  ),
                ),

                // Contact information
           
              ],
            ),
          );
        },
      ),
    );
  }

  // Mobile ke liye menu button aur expandable navigation

  // Mobile navigation menu.
  static Widget _mobileNavigation(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFE8F5E9),
      child: ExpansionTile(
        leading: const Icon(Icons.menu, color: Color(0xFF1B5E20)),
        title: const Text('Menu'),
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Products'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  // Mobile menu ka ek item
  static Widget _mobileMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF2E7D32),
      ),
      title: Text(title),
      onTap: onTap,
    );
  }

  // Filhaal incomplete pages ke liye message
  static void _showComingSoon(
    BuildContext context,
    String pageName,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$pageName page abhi banana baaki hai.'),
      ),
    );
  }

  // Category card
  static Widget _categoryCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD5E4CF),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 38,
            color: const Color(0xFF2E7D32),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Featured product card
  static Widget _productCard({
    required String imagePath,
    required String productName,
    required String category,
    required String description,
  }) {
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
          // Product image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Image.asset(
              imagePath,
              height: 155,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Product details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
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
}
