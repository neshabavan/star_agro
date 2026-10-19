
import 'package:get/get.dart';

import 'package:star_agro/App/home/home_screen.dart';
import 'package:star_agro/App/product/product_screen.dart';
import 'package:star_agro/App/about/about_screen.dart';
import 'package:star_agro/App/contact/contact_screen.dart';
import 'package:star_agro/App/admin/admin_login_screen.dart';
import 'package:star_agro/App/admin/admin_product_screen.dart';

class Approuter {
  // All screen route names
  static const String home = '/home';
  static const String product = '/products';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String adminLogin = '/admin-login';
  static const String adminProducts = '/admin-products';

  // All app pages
  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: product,
      page: () => const ProductScreen(),
    ),
    GetPage(
      name: about,
      page: () => const AboutScreen(),
    ),
    GetPage(
      name: contact,
      page: () => const ContactScreen(),
    ),
    GetPage(
      name: adminLogin,
      page: () => const AdminLoginScreen(),
    ),
    GetPage(
      name: adminProducts,
      page: () => const AdminProductScreen(),
    ),
  ];
}
