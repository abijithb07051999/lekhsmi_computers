import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('Category View - Under Construction', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
