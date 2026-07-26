import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/invoice_bill_controller.dart';

class InvoiceBillView extends GetView<InvoiceBillController> {
  const InvoiceBillView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('InvoiceBill View - Under Construction', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
