import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/app/routes/app_pages.dart';
import 'package:lekhsmi_computers_flutter/main.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: AppPages.HOME, page: () => const MyHomePage())
  ];
}