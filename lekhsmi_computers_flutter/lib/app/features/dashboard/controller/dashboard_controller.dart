import 'package:get/get.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';

class DashboardController extends GetxController {
  final client = Get.find<Client>();
  Future<int> getTodayTotalIncome() async {
    return client.dashboard.getTotalOfThisMonthIncome(
      DateTime.now(),
    );
  }

  Future<int> totalBrandCounts() async {
    return client.dashboard.totalBrandCountrs();
  }

  Future<int> totalCategoryCount() async {
    return client.dashboard.totalCategoryCount();
  }

  Future<int> totalSupplierCount() async {
    return client.dashboard.totalSupplierCount();
  }

  Future<List<Supplier>> getFirstFiveSuppliers() async{
    return client.dashboard.getFirstFiveSupplires();
  }

  Future<List<Product>> getFirstFiveOutOfStockProduct() async{
    return client.dashboard.getFirstFiveOutOfStockProduct();
  }

  Future<List<OrderHistory>> getFiveOrdersData() async{
    return client.dashboard.getFirstFiveLiveOrder();
  }
}
