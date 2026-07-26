import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('Orders View - Under Construction', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
