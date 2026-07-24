import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/app/routes/app_pages.dart';
import 'package:lekhsmi_computers_flutter/app/routes/app_routes.dart';
import 'package:lekhsmi_computers_flutter/binding/bindings.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: LekhsmiBindings(),
      title: "Lekhsmi Computers",
      initialRoute: AppPages.HOME,
      getPages: AppRoutes.routes,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
      ),
    );
  }
}
