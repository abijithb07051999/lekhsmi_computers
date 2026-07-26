import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/accounts_controller.dart';

class AccountsView extends GetView<AccountsController> {
  const AccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('Accounts View - Under Construction', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
