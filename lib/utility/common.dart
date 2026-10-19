
import 'package:flutter/material.dart';
import 'colors.dart';

// Common page heading
class CommonPageTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const CommonPageTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 15,
            color: greyColor,
          ),
        ),
      ],
    );
  }
}

// Common loading indicator
class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: primaryGreen,
      ),
    );
  }
}
