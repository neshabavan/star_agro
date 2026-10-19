
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_agro/utility/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Star Agro',
      debugShowCheckedModeBanner: false,
      initialRoute: Approuter.home,
      getPages: Approuter.routes,
    );
  }
}
