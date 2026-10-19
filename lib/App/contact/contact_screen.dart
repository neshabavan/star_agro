
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F2),

      // Contact page ka header.
      appBar: AppBar(
        title: const Text(
          'Contact Star Agro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),

      // Contact page ka content.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome banner.
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
                    Icons.support_agent,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Get in Touch',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We welcome your questions about our products.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Contact Information',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 16),

            // Shop address.
            _contactCard(
              Icons.location_on,
              'Shop Address',
              'Aysha complex, shop no. 2,Opposite Bus Stand,Gadha,Ta : Himatnagar - 383001',
            ),

            // Shop phone.
            _contactCard(
              Icons.phone,
              'Phone Number',
              '7016192125\n9974069795',
            ),

            // Shop hours.
            _contactCard(
              Icons.access_time,
              'Shop Timings',
              'Morning : 8AM to 1PM\nEvening : 3PM to 6PM',
            ),

            // Email address.
            _contactCard(
              Icons.email,
              'Email Address',
              'javedbavan@gmail.com',
            ),

            const SizedBox(height: 20),

            // Gujarati information.
            const Text(
              'અમારો સંપર્ક કરો',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Star Agro વિશે વધુ માહિતી મેળવવા માટે અમારી '
              'દુકાનની સંપર્ક વિગતોનો ઉપયોગ કરો.',
              style: TextStyle(fontSize: 16, height: 1.7),
            ),

            const SizedBox(height: 20),

            // Hindi information.
            const Text(
              'संपर्क करें',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Star Agro के उत्पादों के बारे में अधिक जानकारी '
              'के लिए दुकान की संपर्क जानकारी का उपयोग करें।',
              style: TextStyle(fontSize: 16, height: 1.7),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Contact detail card.
  static Widget _contactCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 27,
              color: const Color(0xFF2E7D32),
            ),
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
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFF666666),
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
