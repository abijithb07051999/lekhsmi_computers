import 'package:get/get.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';

class DashboardController extends GetxController {
  final client = Get.find<Client>();

  final totalIncome = 0.obs;
  final brandCount = 0.obs;
  final categoryCount = 0.obs;
  final supplierCount = 0.obs;
  final suppliers = <Supplier>[].obs;
  final outOfStockProducts = <Product>[].obs;
  final recentOrders = <OrderHistory>[].obs;
  final allBrands = <Brand>[].obs;
  final allCategories = <Category>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    refreshDashboardData();
  }

  String getBrandName(Product p) {
    if (p.brand != null && p.brand!.name.isNotEmpty) return p.brand!.name;
    for (final b in allBrands) {
      if (b.id == p.brandId) return b.name;
    }
    return 'Unknown';
  }

  String getCategoryName(Product p) {
    if (p.category != null && p.category!.name.isNotEmpty) return p.category!.name;
    for (final c in allCategories) {
      if (c.id == p.categoryId) return c.name;
    }
    return 'Unknown';
  }

  Future<void> refreshDashboardData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        getTodayTotalIncome(),
        totalBrandCounts(),
        totalCategoryCount(),
        totalSupplierCount(),
        getFirstFiveSuppliers(),
        getFirstFiveOutOfStockProduct(),
        getFiveOrdersData(),
        client.brand.getAllBrands(),
        client.category.getAllCategories(),
      ]);
      totalIncome.value = results[0] as int;
      brandCount.value = results[1] as int;
      categoryCount.value = results[2] as int;
      supplierCount.value = results[3] as int;
      suppliers.assignAll(results[4] as List<Supplier>);
      outOfStockProducts.assignAll(results[5] as List<Product>);
      recentOrders.assignAll(results[6] as List<OrderHistory>);
      allBrands.assignAll(results[7] as List<Brand>);
      allCategories.assignAll(results[8] as List<Category>);
    } catch (e) {
      // Keep silent on transient dashboard errors
    } finally {
      isLoading.value = false;
    }
  }

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

