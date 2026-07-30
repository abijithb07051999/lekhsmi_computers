import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import '../../product/controller/product_controller.dart';
import '../../../dashboard/controller/dashboard_controller.dart';
import '../../../invoice_bill/controller/invoice_bill_controller.dart';

class PurchaseController extends GetxController {
  final Client _client = Get.find<Client>();

  final RxList<Purchase> purchases = <Purchase>[].obs;
  final RxList<Supplier> suppliers = <Supplier>[].obs;
  final RxList<Product> products = <Product>[].obs;
  final RxList<Brand> brands = <Brand>[].obs;
  final RxList<Category> categories = <Category>[].obs;

  final RxBool isLoadingPurchases = true.obs;
  final RxBool isSubmitting = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  void refreshAll() {
    fetchPurchases();
  }

  void _notifyStockUpdated() {
    if (Get.isRegistered<ProductController>()) {
      Get.find<ProductController>().fetchProducts();
    }
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().refreshDashboardData();
    }
    if (Get.isRegistered<InvoiceBillController>()) {
      Get.find<InvoiceBillController>().refreshProducts();
    }
  }

  Future<void> fetchPurchases() async {
    try {
      isLoadingPurchases.value = true;
      final results = await Future.wait([
        _client.purchase.getAllPurchases(),
        _client.supplier.getAllSuppliers(),
        _client.product.getAllProducts(),
        _client.brand.getAllBrands(),
        _client.category.getAllCategories(),
      ]);
      purchases.assignAll(results[0] as List<Purchase>);
      suppliers.assignAll(results[1] as List<Supplier>);
      products.assignAll(results[2] as List<Product>);
      brands.assignAll(results[3] as List<Brand>);
      categories.assignAll(results[4] as List<Category>);
    } catch (e) {
      AppNotification.error('Error', 'Failed to load purchase data: $e');
    } finally {
      isLoadingPurchases.value = false;
    }
  }

  List<Purchase> get filteredPurchases {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return purchases;
    return purchases.where((p) {
      final supplierName = getSupplierName(p).toLowerCase();
      return p.invoiceNo.toLowerCase().contains(query) ||
          supplierName.contains(query) ||
          p.paymentStatus.toLowerCase().contains(query);
    }).toList();
  }

  String getSupplierName(Purchase purchase) {
    if (purchase.supplier != null) return purchase.supplier!.name;
    for (final s in suppliers) {
      if (s.id == purchase.supplierId) return s.name;
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

  String getCategoryName(Product product) {
    if (product.category != null) return product.category!.name;
    for (final c in categories) {
      if (c.id == product.categoryId) return c.name;
    }
    return '-';
  }

  String generateInvoiceNumber() {
    final now = DateTime.now();
    final yy = (now.year % 100).toString().padLeft(2, '0');
    final mm = now.month.toString().padLeft(2, '0');
    final dd = now.day.toString().padLeft(2, '0');
    final hh = now.hour.toString().padLeft(2, '0');
    final min = now.minute.toString().padLeft(2, '0');
    final ss = now.second.toString().padLeft(2, '0');
    return '#$yy$mm$dd$hh$min$ss';
  }

  Future<List<PurchaseItem>> fetchItemsForPurchase(int purchaseId) async {
    try {
      return await _client.purchase.getPurchaseItems(purchaseId: purchaseId);
    } catch (e) {
      AppNotification.error('Error', 'Failed to load purchase items: $e');
      return [];
    }
  }

  Future<bool> createNewPurchase({
    required Purchase purchase,
    required List<PurchaseItem> items,
  }) async {
    try {
      isSubmitting.value = true;
      await _client.purchase.createPurchase(purchase: purchase, items: items);
      await fetchPurchases();
      _notifyStockUpdated();
      AppNotification.success('Success', 'Purchase recorded and stock updated successfully');
      return true;
    } catch (e) {
      AppNotification.error('Error', 'Failed to record purchase: $e');
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> updatePurchasePayment(Purchase purchase) async {
    try {
      await _client.purchase.updatePurchase(purchase: purchase);
      await fetchPurchases();
      _notifyStockUpdated();
      AppNotification.success('Success', 'Payment updated successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to update payment: $e');
    }
  }

  Future<void> deletePurchase(Purchase purchase) async {
    try {
      await _client.purchase.deletePurchase(purchase: purchase);
      await fetchPurchases();
      _notifyStockUpdated();
      AppNotification.success('Success', 'Purchase deleted successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to delete purchase: $e');
    }
  }
}

