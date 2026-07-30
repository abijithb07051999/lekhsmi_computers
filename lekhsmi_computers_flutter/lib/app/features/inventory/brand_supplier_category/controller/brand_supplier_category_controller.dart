import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import '../../../dashboard/controller/dashboard_controller.dart';

class BrandSupplierCategoryController extends GetxController {
  final Client _client = Get.find<Client>();

  // Observable lists
  final RxList<Brand> brands = <Brand>[].obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Supplier> suppliers = <Supplier>[].obs;

  // Loading states
  final RxBool isLoadingBrands = true.obs;
  final RxBool isLoadingCategories = true.obs;
  final RxBool isLoadingSuppliers = true.obs;

  // Search queries
  final RxString brandSearchQuery = ''.obs;
  final RxString categorySearchQuery = ''.obs;
  final RxString supplierSearchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    refreshAll();
  }

  void refreshAll() {
    fetchBrands();
    fetchCategories();
    fetchSuppliers();
  }

  void _notifyDashboard() {
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().refreshDashboardData();
    }
  }

  Future<List<Brand>> getAllBrands() async {
    return _client.brand.getAllBrands();
  }

  Future<List<Category>> getAllCategory() async {
    return _client.category.getAllCategories();
  }

  Future<List<Supplier>> getAllSuppliers() async {
    return _client.supplier.getAllSuppliers();
  }

  Future<void> fetchBrands() async {
    try {
      isLoadingBrands.value = true;
      final fetched = await getAllBrands();
      brands.assignAll(fetched);
    } catch (e) {
      AppNotification.error('Error', 'Failed to load brands: $e');
    } finally {
      isLoadingBrands.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final fetched = await getAllCategory();
      categories.assignAll(fetched);
    } catch (e) {
      AppNotification.error('Error', 'Failed to load categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

  Future<void> fetchSuppliers() async {
    try {
      isLoadingSuppliers.value = true;
      final fetched = await getAllSuppliers();
      suppliers.assignAll(fetched);
    } catch (e) {
      AppNotification.error('Error', 'Failed to load suppliers: $e');
    } finally {
      isLoadingSuppliers.value = false;
    }
  }

  // Filtered Lists
  List<Brand> get filteredBrands {
    if (brandSearchQuery.value.trim().isEmpty) return brands;
    final q = brandSearchQuery.value.trim().toLowerCase();
    return brands.where((b) => b.name.toLowerCase().contains(q)).toList();
  }

  List<Category> get filteredCategories {
    if (categorySearchQuery.value.trim().isEmpty) return categories;
    final q = categorySearchQuery.value.trim().toLowerCase();
    return categories.where((c) => c.name.toLowerCase().contains(q)).toList();
  }

  List<Supplier> get filteredSuppliers {
    if (supplierSearchQuery.value.trim().isEmpty) return suppliers;
    final q = supplierSearchQuery.value.trim().toLowerCase();
    return suppliers.where((s) =>
      s.name.toLowerCase().contains(q) ||
      s.address.toLowerCase().contains(q) ||
      s.contact1.toString().contains(q) ||
      s.contact2.toString().contains(q)
    ).toList();
  }

  // Add Brand
  Future<void> addBrand(Brand brand) async {
    try {
      await _client.brand.addNewBrand(brand: brand);
      await fetchBrands();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Brand added successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to add brand: $e');
    }
  }

  // Add Category
  Future<void> addCategory(Category category) async {
    try {
      await _client.category.addNewCategory(category: category);
      await fetchCategories();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Category added successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to add category: $e');
    }
  }

  // Add Supplier
  Future<void> addSupplier(Supplier supplier) async {
    try {
      await _client.supplier.addNewSupplier(supplier: supplier);
      await fetchSuppliers();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Supplier added successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to add supplier: $e');
    }
  }

  // Update Brand
  Future<void> updateBrand(Brand brand) async {
    try {
      await _client.brand.updateExistingBrand(brand: brand);
      await fetchBrands();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Brand updated successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to update brand: $e');
    }
  }

  // Update Category
  Future<void> updateCategory(Category category) async {
    try {
      await _client.category.updateExistingCategory(category: category);
      await fetchCategories();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Category updated successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to update category: $e');
    }
  }

  // Update Supplier
  Future<void> updateSupplier(Supplier supplier) async {
    try {
      await _client.supplier.updateExistingSupplier(supplier: supplier);
      await fetchSuppliers();
      _notifyDashboard();
      Get.back();
      AppNotification.success('Success', 'Supplier updated successfully');
    } catch (e) {
      AppNotification.error('Error', 'Failed to update supplier: $e');
    }
  }
}

