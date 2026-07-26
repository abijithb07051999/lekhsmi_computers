import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/brands_controller.dart';

class BrandsView extends GetView<BrandsController> {
  const BrandsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('Brands View - Under Construction', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
