
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  // Website ke featured categories
  final List<String> categories = [
    'Seeds',
    'Fertilizers',
    'Pesticides',
    'Agricultural Tools',
  ];

  // Shop ki basic information
  final String shopName = 'Star Agro';

  final String tagline =
      'Your Trusted Partner in Agriculture';

  // Selected navigation page
  int selectedIndex = 0;

  // Navigation selection update karna
  void changePage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
