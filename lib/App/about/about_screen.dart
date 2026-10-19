
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F2),

      // About page ka header.
      appBar: AppBar(
        title: const Text(
          'About Star Agro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),

      // About page ka content.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Green welcome banner.
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2E7D32),
                    Color(0xFF1B5E20),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.agriculture,
                    size: 65,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome to Star Agro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Your trusted partner in agriculture.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // About heading.
            const Text(
              'Who We Are',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Star Agro is focused on providing agricultural '
              'products for farmers and their farming needs. '
              'Our goal is to make it easier for customers to '
              'explore the products available at our shop.',
              style: TextStyle(
                fontSize: 16,
                height: 1.7,
                color: Color(0xFF444444),
              ),
            ),

            const SizedBox(height: 24),

            // Hamara purpose.
            const Text(
              'Our Purpose',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 12),

            _infoCard(
              Icons.eco,
              'Agricultural Products',
              'Explore products related to seeds, fertilizers and '
                  'crop care. ',
            ),

            _infoCard(
              Icons.people,
              'Farmer Support',
              'Our aim is to help customers find products '
                  'that suit their farming requirements.',
            ),

            _infoCard(
              Icons.handshake,
              'Customer Trust',
              'We aim to provide helpful information about '
                  'the products available at Star Agro.',
            ),

            const SizedBox(height: 24),

            // Gujarati and Hindi introduction.
            const Text(
              'અમારા વિશે',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Star Agro ખેડૂતોની ખેતી સંબંધિત જરૂરિયાતો માટે '
              'કૃષિ ઉત્પાદનોની માહિતી ઉપલબ્ધ કરાવવામાં મદદ કરે છે.',
              style: TextStyle(fontSize: 16, height: 1.7),
            ),

            const SizedBox(height: 20),

            const Text(
              'हमारे बारे में',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Star Agro किसानों की खेती से जुड़ी जरूरतों के '
              'लिए कृषि उत्पादों की जानकारी उपलब्ध कराने का '
              'प्रयास करता है।',
              style: TextStyle(fontSize: 16, height: 1.7),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Information card.
  static Widget _infoCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD5E4CF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 32,
            color: const Color(0xFF2E7D32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF555555),
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
