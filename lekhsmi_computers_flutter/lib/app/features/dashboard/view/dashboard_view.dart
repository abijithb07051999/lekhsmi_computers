import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final controller = Get.put(DashboardController());

  String _selectedMenu = 'Dashboard';

  late Future<int> _totalIncomeFuture;
  late Future<int> _brandCountFuture;
  late Future<int> _categoryCountFuture;
  late Future<int> _supplierCountFuture;
  late Future<List<Supplier>> _suppliersFuture;
  late Future<List<Product>> _outOfStockFuture;
  late Future<List<OrderHistory>> _orderHistoryFuture;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    _totalIncomeFuture = controller.getTodayTotalIncome();
    _brandCountFuture = controller.totalBrandCounts();
    _categoryCountFuture = controller.totalCategoryCount();
    _supplierCountFuture = controller.totalSupplierCount();
    _suppliersFuture = controller.getFirstFiveSuppliers();
    _outOfStockFuture = controller.getFirstFiveOutOfStockProduct();
    _orderHistoryFuture = controller.getFiveOrdersData();
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.BACKGROUND),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sleek Sidebar (No explicit background color)
          SizedBox(
            width: 280,
            child: Column(
              children: [
                // Logo Area
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 40, 28, 20),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(AppColors.PRIMARY),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: const Color(AppColors.PRIMARY).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6)),
                          ],
                        ),
                        child: const Center(
                          child: Text('LC', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'LEKSHMI\nCOMPUTERS',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY), height: 1.1, letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // Navigation
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildNavItem('Dashboard', AppIcons.DASHBOARDICON),
                      _buildNavExpansionItem('Inventory', AppIcons.INVENTORYICON, ['Brands / Suppliers', 'Purchases / History', 'Products / Stocks']),
                      _buildNavExpansionItem('Orders', AppIcons.ORDERICON, ['New Order', 'Live / History']),
                      _buildNavExpansionItem('Accounts', AppIcons.ACCOUNSTICON, ['Income / Expense', 'Report']),
                      _buildNavItem('Quotation', AppIcons.QUOTATIONICON),
                      _buildNavItem('Invoice / Bill', AppIcons.INVOICEICON),
                      _buildNavItem('Settings', AppIcons.SETTINGSICON),
                    ],
                  ),
                ),
                
                // Footer
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      const Icon(Icons.all_inclusive, color: Color(AppColors.SECONDAY), size: 32),
                      const SizedBox(height: 12),
                      Text(
                        'LoopSpring Technologies\nConsultancy PVT. LTD',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: const Color(AppColors.TEXTSECONDARY).withOpacity(0.6), fontWeight: FontWeight.bold, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), bottomLeft: Radius.circular(32)),
              child: Container(
                color: const Color(0xFFF1F5F9), // Slightly different shade to create modern depth
                child: _selectedMenu == 'Dashboard' 
                    ? _buildDashboardContent() 
                    : _buildEmptyContent(_selectedMenu),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyContent(String title) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(icon: AppIcons.DASHBOARDICON, color: const Color(AppColors.TEXTSECONDARY).withOpacity(0.5), size: 48),
            const SizedBox(height: 16),
            Text('$title View', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(AppColors.TEXTPRIMARY))),
            const SizedBox(height: 8),
            const Text('This section is currently under construction.', style: TextStyle(fontSize: 14, color: Color(AppColors.TEXTSECONDARY))),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return Column(
      children: [
        // Top Header
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
          child: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Overview', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY), letterSpacing: -0.5)),
                  SizedBox(height: 4),
                  Text('Here is your business summary today.', style: TextStyle(fontSize: 14, color: Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w500)),
                ],
              ),
              const Spacer(),
              // Date Widget
              Row(
                children: [
                  const HugeIcon(icon: AppIcons.CALENDARICON, color: Color(AppColors.TEXTSECONDARY), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(DateTime.now()),
                    style: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metrics Row
                Row(
                  children: [
                    Expanded(child: _buildMetricFuture('Total Income', AppIcons.TOTALINCOMEICON, const Color(AppColors.PRIMARY), _totalIncomeFuture, isCurrency: true)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildMetricFuture('Brands', AppIcons.BRANDSCOUNTICON, const Color(AppColors.SECONDAY), _brandCountFuture)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildMetricFuture('Categories', AppIcons.CATEGORYCOUNTICON, const Color(AppColors.INFO), _categoryCountFuture)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildMetricFuture('Suppliers', AppIcons.SUPPLIERCOUNTICON, const Color(AppColors.WARNING), _supplierCountFuture)),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Tables Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _buildSuppliersTable()),
                    const SizedBox(width: 16),
                    Expanded(flex: 4, child: _buildOrderHistoryTable()),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Out of Stock Table
                _buildOutOfStockTable(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(String title, dynamic icon) {
    bool isActive = _selectedMenu == title;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isActive ? [BoxShadow(color: const Color(AppColors.PRIMARY).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))] : [],
      ),
      child: Material(
        color: isActive ? const Color(AppColors.PRIMARY) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          leading: HugeIcon(icon: icon, color: isActive ? Colors.white : const Color(AppColors.TEXTSECONDARY), size: 22),
          title: Text(
            title,
            style: TextStyle(color: isActive ? Colors.white : const Color(AppColors.TEXTSECONDARY), fontWeight: isActive ? FontWeight.w800 : FontWeight.w600, fontSize: 14),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          onTap: () {
            setState(() {
              _selectedMenu = title;
            });
          },
        ),
      ),
    );
  }

  Widget _buildNavExpansionItem(String title, dynamic icon, List<String> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          leading: HugeIcon(icon: icon, color: const Color(AppColors.TEXTSECONDARY), size: 22),
          title: Text(title, style: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600, fontSize: 14)),
          trailing: const Icon(Icons.keyboard_arrow_down, color: Color(AppColors.TEXTSECONDARY), size: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 44, right: 16, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children.map((e) {
              bool isActive = _selectedMenu == e;
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isActive ? [BoxShadow(color: const Color(AppColors.PRIMARY).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))] : [],
                ),
                child: Material(
                  color: isActive ? const Color(AppColors.PRIMARY) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    title: Text(e, style: TextStyle(color: isActive ? Colors.white : const Color(AppColors.TEXTSECONDARY), fontSize: 13, fontWeight: isActive ? FontWeight.w800 : FontWeight.w500)),
                    visualDensity: const VisualDensity(vertical: -4),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    onTap: () {
                      setState(() {
                        _selectedMenu = e;
                      });
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricFuture(String title, dynamic icon, Color color, Future<int> future, {bool isCurrency = false, bool isPrimary = false}) {
    final bgColor = isPrimary ? const Color(AppColors.PRIMARY) : const Color(AppColors.WHITE);
    final textColorPrimary = isPrimary ? Colors.white : const Color(AppColors.TEXTPRIMARY);
    final textColorSecondary = isPrimary ? Colors.white70 : const Color(AppColors.TEXTSECONDARY);
    final iconBgColor = isPrimary ? Colors.white.withOpacity(0.2) : color.withOpacity(0.1);
    final iconColor = isPrimary ? Colors.white : color;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(20)),
            child: HugeIcon(icon: icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: textColorSecondary, fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                FutureBuilder<int>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(height: 28, width: 28, child: CircularProgressIndicator(strokeWidth: 2));
                    }
                    if (snapshot.hasError) {
                      return Text('Error', style: TextStyle(color: isPrimary ? Colors.white : const Color(AppColors.ERROR), fontSize: 16, fontWeight: FontWeight.bold));
                    }
                    final value = snapshot.data ?? 0;
                    final displayValue = isCurrency ? '₹$value' : value.toString();
                    return Text(displayValue, style: TextStyle(color: textColorPrimary, fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY))),
        Container(
          decoration: BoxDecoration(color: const Color(AppColors.PRIMARY).withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('View All', style: TextStyle(color: Color(AppColors.PRIMARY), fontWeight: FontWeight.w700, fontSize: 13)),
          ),
        ),
      ],
    );
  }

  Widget _buildSuppliersTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader('Recent Suppliers'),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Name', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 4, child: Text('Address', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('Contact', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          FutureBuilder<List<Supplier>>(
            future: _suppliersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
              if (snapshot.hasError) return Padding(padding: const EdgeInsets.all(20), child: Text('Failed to load suppliers: ${snapshot.error}'));
              final suppliers = snapshot.data ?? [];
              if (suppliers.isEmpty) return const Padding(padding: EdgeInsets.all(40), child: Center(child: Text('No suppliers found', style: TextStyle(color: Color(AppColors.TEXTSECONDARY)))));
              
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: suppliers.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  final s = suppliers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(s.name, style: const TextStyle(color: Color(AppColors.TEXTPRIMARY), fontSize: 14, fontWeight: FontWeight.w700))),
                        Expanded(flex: 4, child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(s.address, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 13, height: 1.5)),
                        )),
                        Expanded(flex: 3, child: Align(alignment: Alignment.centerLeft, child: _buildContactChip(s.contact1.toString()))),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactChip(String number) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.withOpacity(0.1))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HugeIcon(icon: AppIcons.PHONEICON, color: Color(AppColors.TEXTSECONDARY), size: 14),
          const SizedBox(width: 8),
          Text(number, style: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildOrderHistoryTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader('Live Orders'),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Customer', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Date', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Amount', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Status', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          FutureBuilder<List<OrderHistory>>(
            future: _orderHistoryFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
              if (snapshot.hasError) return Padding(padding: const EdgeInsets.all(20), child: Text('Failed to load orders: ${snapshot.error}'));
              final orders = snapshot.data ?? [];
              if (orders.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: [
                        HugeIcon(icon: AppIcons.ORDERICON, color: Color(AppColors.TEXTSECONDARY), size: 32),
                        SizedBox(height: 12),
                        Text('No live orders found', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              }
              
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  final o = orders[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(o.order.customerName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(AppColors.TEXTPRIMARY), fontSize: 14, fontWeight: FontWeight.w700))),
                        Expanded(flex: 2, child: Text(_formatDate(o.order.date), maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 13, fontWeight: FontWeight.w500))),
                        Expanded(flex: 2, child: Text('₹${o.amount}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(AppColors.TEXTPRIMARY), fontSize: 14, fontWeight: FontWeight.w800))),
                        Expanded(flex: 2, child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: const Color(AppColors.WARNING).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                            child: Text(o.status, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(AppColors.WARNING), fontSize: 12, fontWeight: FontWeight.w700)),
                          ),
                        )),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOutOfStockTable() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader('Out of Stock Products'),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Product Name', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Brand', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Quality', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Buy Price', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Sell Price', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Profit', style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
                Expanded(flex: 1, child: Text('Action', textAlign: TextAlign.center, style: TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          FutureBuilder<List<Product>>(
            future: _outOfStockFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) return const Padding(padding: EdgeInsets.all(40), child: Center(child: CircularProgressIndicator()));
              if (snapshot.hasError) return Padding(padding: const EdgeInsets.all(20), child: Text('Failed to load products: ${snapshot.error}'));
              final products = snapshot.data ?? [];
              if (products.isEmpty) return const Padding(padding: EdgeInsets.all(40), child: Center(child: Text('No products are out of stock', style: TextStyle(color: Color(AppColors.TEXTSECONDARY)))));
              
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  final p = products[index];
                  final profit = p.sellPrice - p.buyPrice;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text(p.name, style: const TextStyle(color: Color(AppColors.TEXTPRIMARY), fontSize: 14, fontWeight: FontWeight.w700))),
                        Expanded(flex: 2, child: Text(p.brand?.name ?? 'Unknown', style: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 13, fontWeight: FontWeight.w600))),
                        Expanded(flex: 2, child: Text(p.quality, style: const TextStyle(color: Color(AppColors.INFO), fontSize: 13, fontWeight: FontWeight.w700))),
                        Expanded(flex: 2, child: Text('₹${p.buyPrice}', style: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 13, fontWeight: FontWeight.w600))),
                        Expanded(flex: 2, child: Text('₹${p.sellPrice}', style: const TextStyle(color: Color(AppColors.TEXTPRIMARY), fontSize: 13, fontWeight: FontWeight.w700))),
                        Expanded(flex: 2, child: Text('₹$profit', style: const TextStyle(color: Color(AppColors.SUCCESS), fontSize: 13, fontWeight: FontWeight.w800))),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: const Color(AppColors.PRIMARY).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                                child: const HugeIcon(icon: AppIcons.EDITICON, color: Color(AppColors.PRIMARY), size: 16),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}