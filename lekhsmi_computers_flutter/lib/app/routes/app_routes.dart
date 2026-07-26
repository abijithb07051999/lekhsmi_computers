import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/app/features/dashboard/view/dashboard_view.dart';
import 'package:lekhsmi_computers_flutter/app/routes/app_pages.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: AppPages.DASHBOARD, page: () => const DashboardView())
  ];
}