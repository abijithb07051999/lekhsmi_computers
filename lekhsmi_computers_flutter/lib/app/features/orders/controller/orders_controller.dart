import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/app/features/dashboard/controller/dashboard_controller.dart';

class OrdersController extends GetxController {
  final Client _client = Get.find<Client>();

  final RxList<OrderHistory> liveOrders = <OrderHistory>[].obs;
  final RxList<OrderHistory> historyOrders = <OrderHistory>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isHistoryView = false.obs;
  final RxString searchQuery = ''.obs;

  // Year and Month filter for order history
  final RxnInt selectedHistoryYear = RxnInt(DateTime.now().year);
  final RxnInt selectedHistoryMonth = RxnInt(null);

  List<int> get availableHistoryYears {
    final currentYear = DateTime.now().year;
    int earliestYear = currentYear;
    for (final item in historyOrders) {
      if (item.order.date.year < earliestYear) {
        earliestYear = item.order.date.year;
      }
    }
    for (final item in liveOrders) {
      if (item.order.date.year < earliestYear) {
        earliestYear = item.order.date.year;
      }
    }
    final years = <int>[];
    for (int y = currentYear; y >= earliestYear; y--) {
      years.add(y);
    }
    return years;
  }

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void _notifyDashboard() {
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().refreshDashboardData();
    }
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _client.order.getAllOngoingAndPendingOrders(),
        _client.order.getAllCompletedAndConcelledOrders(),
      ]);
      final live = results[0];
      final hist = results[1];
      // Sort by insertion order descending (last order first, previous one second)
      live.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      hist.sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));

      liveOrders.assignAll(live);
      historyOrders.assignAll(hist);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String generateOrderId() {
    final now = DateTime.now();
    final year = now.year.toString().substring(2);
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    return '#ORD$year$month$day$hour$minute$second';
  }

  Future<bool> createNewOrder({
    required String customerName,
    required int contact1,
    int? contact2,
    String? email,
    required String address,
    required DateTime date,
    required List<String> complaints,
    int amount = 0,
  }) async {
    try {
      isLoading.value = true;
      final newOrder = Orders(
        orderId: generateOrderId(),
        customerName: customerName,
        contact1: contact1,
        contact2: contact2,
        email: email,
        address: address,
        date: date,
        complaints: complaints,
      );
      final createdOrder = await _client.order.addNewOrder(order: newOrder);
      final statusItem = OrderHistory(
        order: createdOrder,
        status: 'Pending',
        amount: amount,
      );
      await _client.order.addNewOrderStatus(statusItem);
      await fetchOrders();
      _notifyDashboard();
      Get.snackbar(
        'Success',
        'Order created successfully (${createdOrder.orderId})',
        backgroundColor: Colors.green.shade50,
        colorText: Colors.green.shade800,
      );
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to create order: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrderStatus(OrderHistory item, String newStatus) async {
    try {
      item.status = newStatus;
      await _client.order.updateOrderStatus(item);
      await fetchOrders();
      _notifyDashboard();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update status: $e');
    }
  }

  Future<bool> updateExistingOrderDetails({
    required OrderHistory historyItem,
    required String customerName,
    required int contact1,
    int? contact2,
    String? email,
    required String address,
    required DateTime date,
    required List<String> complaints,
    required int amount,
  }) async {
    try {
      isLoading.value = true;
      final order = historyItem.order;
      order.customerName = customerName;
      order.contact1 = contact1;
      order.contact2 = contact2;
      order.email = email;
      order.address = address;
      order.date = date;
      order.complaints = complaints;

      await _client.order.updateExistingOrder(order: order);

      historyItem.amount = amount;
      await _client.order.updateOrderStatus(historyItem);

      await fetchOrders();
      _notifyDashboard();
      Get.snackbar(
        'Order Updated',
        'Order ${order.orderId} was updated successfully.',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update order details: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrderAmount(OrderHistory item, int newAmount) async {
    try {
      item.amount = newAmount;
      await _client.order.updateOrderStatus(item);
      await fetchOrders();
      _notifyDashboard();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update price: $e');
    }
  }

  List<OrderHistory> get displayedOrders {
    final list = liveOrders;
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return list;
    return list.where((item) {
      final o = item.order;
      return o.orderId.toLowerCase().contains(query) ||
          o.customerName.toLowerCase().contains(query) ||
          o.contact1.toString().contains(query) ||
          (o.email?.toLowerCase().contains(query) ?? false) ||
          item.status.toLowerCase().contains(query);
    }).toList();
  }

  List<OrderHistory> getFilteredHistoryOrders(String queryText) {
    final list = historyOrders;
    final query = queryText.trim().toLowerCase();
    List<OrderHistory> filtered = list;

    if (selectedHistoryYear.value != null) {
      filtered = filtered.where((item) => item.order.date.year == selectedHistoryYear.value).toList();
    }
    if (selectedHistoryMonth.value != null) {
      filtered = filtered.where((item) => item.order.date.month == selectedHistoryMonth.value).toList();
    }

    if (query.isEmpty) return filtered;
    return filtered.where((item) {
      final o = item.order;
      return o.orderId.toLowerCase().contains(query) ||
          o.customerName.toLowerCase().contains(query) ||
          o.contact1.toString().contains(query) ||
          (o.email?.toLowerCase().contains(query) ?? false) ||
          item.status.toLowerCase().contains(query);
    }).toList();
  }

  // Legacy stubs kept for compatibility if needed
  Future<List<Orders>> getAllOrders() async {
    return _client.order.getAllOrders();
  }

  Future<void> addNewOrder(Orders order) async {
    await _client.order.addNewOrder(order: order);
  }
}
