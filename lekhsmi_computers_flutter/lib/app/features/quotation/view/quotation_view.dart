import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quotation_controller.dart';

class QuotationView extends GetView<QuotationController> {
  const QuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('Quotation View - Under Construction', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
