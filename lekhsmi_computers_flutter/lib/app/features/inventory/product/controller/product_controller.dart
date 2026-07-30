import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import '../../../dashboard/controller/dashboard_controller.dart';
import '../../purchase/controller/purchase_controller.dart';
import '../../../invoice_bill/controller/invoice_bill_controller.dart';

class ProductController extends GetxController {
  final Client _client = Get.find<Client>();

  final RxList<Product> products = <Product>[].obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Brand> brands = <Brand>[].obs;

  final RxBool isLoadingProducts = true.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  void refreshAll() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoadingProducts.value = true;
      final results = await Future.wait([
        _client.product.getAllProducts(),
        _client.category.getAllCategories(),
        _client.brand.getAllBrands(),
      ]);
      products.assignAll(results[0] as List<Product>);
      categories.assignAll(results[1] as List<Category>);
      brands.assignAll(results[2] as List<Brand>);
    } catch (e) {
      AppNotification.error('Error', 'Failed to load products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  List<Product> get filteredProducts {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return products;
    return products.where((p) {
      final categoryName = getCategoryName(p).toLowerCase();
      final brandName = getBrandName(p).toLowerCase();
      return p.name.toLowerCase().contains(query) ||
          categoryName.contains(query) ||
          brandName.contains(query) ||
          p.quality.toLowerCase().contains(query);
    }).toList();
  }

  String getCategoryName(Product product) {
    if (product.category != null) return product.category!.name;
    for (final c in categories) {
      if (c.id == product.categoryId) return c.name;
    }
    return '-';
  }

  String getBrandName(Product product) {
    if (product.brand != null) return product.brand!.name;
    for (final b in brands) {
      if (b.id == product.brandId) return b.name;
    }
    return '-';
  }

  void _notifyDashboard() {
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().refreshDashboardData();
    }
    if (Get.isRegistered<PurchaseController>()) {
      Get.find<PurchaseController>().fetchPurchases();
    }
    if (Get.isRegistered<InvoiceBillController>()) {
      Get.find<InvoiceBillController>().refreshProducts();
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _client.product.addNewProduct(product: product);
      await fetchProducts();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Product added successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to add product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _client.product.updateExistingProduct(product: product);
      await fetchProducts();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Product updated successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to update product: $e');
    }
  }
}


