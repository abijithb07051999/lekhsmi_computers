import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/suppliers_controller.dart';

class SuppliersView extends GetView<SuppliersController> {
  const SuppliersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('Suppliers View - Under Construction', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
