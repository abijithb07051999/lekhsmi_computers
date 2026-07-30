import 'package:get/get.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

class LekhsmiBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<Client>(
      Client("http://localhost:8080")
        ..connectivityMonitor = FlutterConnectivityMonitor(),
      permanent: true,
    );
    Get.put<SettingsController>(SettingsController(), permanent: true);
  }
}
