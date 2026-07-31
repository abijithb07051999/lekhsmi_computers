import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_flutter/app/features/inventory/brand_supplier_category/view/brand_supplier_category_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/inventory/product/view/product_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/inventory/purchase/view/purchase_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/orders/view/new_order_form.dart';
import 'package:lekhsmi_computers_flutter/app/features/orders/view/live_history_orders.dart';
import 'package:lekhsmi_computers_flutter/app/features/accounts/view/accounts_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/accounts/view/accounts_report_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/quotation/view/quotation_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/invoice_bill/view/invoice_bill_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/view/settings_view.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../controller/dashboard_controller.dart';
import '../../inventory/product/controller/product_controller.dart';
import '../../inventory/purchase/controller/purchase_controller.dart';
import '../../inventory/brand_supplier_category/controller/brand_supplier_category_controller.dart';
import '../../invoice_bill/controller/invoice_bill_controller.dart';
import '../../orders/controller/orders_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final controller = Get.put(DashboardController());

  String _selectedMenu = 'Dashboard';
  int _brandSupplierTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(AppColors.BACKGROUND),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmallScreen = constraints.maxWidth < 1400;
          final double sidebarWidth = constraints.maxWidth < 950
              ? 190.0
              : (constraints.maxWidth < 1200 ? 220.0 : 270.0);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Modern Enterprise SaaS Sidebar
              Container(
                width: sidebarWidth,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border(
                    right: BorderSide(color: Color(0xFFE2E8F0), width: 1),
                  ),
                ),
                child: Column(
                  children: [
                    // Logo & Workspace Brand Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 18),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              'assets/logo/lexmi_computers_logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(AppColors.PRIMARY),
                                  child: Center(
                                    child: Text(
                                      'LC',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                        colors: [
                                          Color(AppColors.PRIMARY),
                                          Color(AppColors.SECONDAY),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                  child: Obx(() {
                                    return Text(
                                      Get.find<SettingsController>()
                                          .storeName
                                          .value,
                                      style: GoogleFonts.inter(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: -0.3,
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      AppColors.PRIMARY,
                                    ).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    'ENTERPRISE ERP',
                                    style: GoogleFonts.inter(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(AppColors.PRIMARY),
                                      letterSpacing: 0.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 16),

                    // Navigation
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              bottom: 8,
                              top: 4,
                            ),
                            child: Text(
                              'MAIN MENU',
                              style: GoogleFonts.inter(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(
                                  AppColors.TEXTSECONDARY,
                                ).withValues(alpha: 0.7),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          _buildNavItem('Dashboard', AppIcons.DASHBOARDICON),
                          _buildNavExpansionItem(
                            'Inventory',
                            AppIcons.INVENTORYICON,
                            [
                              'Brands / Suppliers',
                              'Purchase',
                              'Stocks',
                            ],
                          ),
                          _buildNavExpansionItem('Orders', AppIcons.ORDERICON, [
                            'New Order',
                            'Live / History',
                          ]),
                          _buildNavExpansionItem(
                            'Accounts',
                            AppIcons.ACCOUNSTICON,
                            ['Income / Expense', 'Report'],
                          ),
                          _buildNavItem('Quotation', AppIcons.QUOTATIONICON),
                          _buildNavItem('Invoice / Bill', AppIcons.INVOICEICON),
                          _buildNavItem('Settings', AppIcons.SETTINGSICON),
                        ],
                      ),
                    ),

                    // LoopSpring Footer with Primary-to-Secondary Gradient Logo
                    Padding(
                      padding: EdgeInsets.all(isSmallScreen ? 14.0 : 24.0),
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(AppColors.PRIMARY),
                                Color(AppColors.SECONDAY),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Icon(
                              Icons.all_inclusive,
                              color: Colors.white,
                              size: isSmallScreen ? 24 : 32,
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 12),
                          Text(
                            isSmallScreen
                                ? 'LoopSpring\nTechnologies'
                                : 'LoopSpring Technologies and \nConsultancy PVT. LTD',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: isSmallScreen ? 9.0 : 10.5,
                              color: const Color(
                                AppColors.TEXTSECONDARY,
                              ).withValues(alpha: 0.7),
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  ),
                  child: Container(
                    color: const Color(
                      0xFFF1F5F9,
                    ), // Slightly different shade to create modern depth
                    child: _buildMainContent(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedMenu) {
      case 'Dashboard':
        return _buildDashboardContent();
      case 'Brands / Suppliers':
        return BrandSupplierCategoryView(
          initialTabIndex: _brandSupplierTabIndex,
        );
      case 'Purchase':
        return const PurchaseView();
      case 'Stocks':
        return const ProductView();
      case 'New Order':
        return const NewOrderFormView();
      case 'Live / History':
        return const LiveHistoryOrdersView();
      case 'Income / Expense':
        return const AccountsView();
      case 'Report':
        return const AccountsReportView();
      case 'Quotation':
        return const QuotationView();
      case 'Invoice / Bill':
        return const InvoiceBillView();
      case 'Settings':
        return const SettingsView();
      default:
        return _buildEmptyContent(_selectedMenu);
    }
  }

  Widget _buildEmptyContent(String title) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: AppIcons.DASHBOARDICON,
              color: const Color(
                AppColors.TEXTSECONDARY,
              ).withValues(alpha: 0.5),
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              '$title View',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This section is currently under construction.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(AppColors.TEXTSECONDARY),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < 750;
        return _buildDashboardContentInner(isSmall);
      },
    );
  }

  Widget _buildDashboardContentInner(bool isSmall) {
    return Column(
      children: [
        // Premium Enterprise Top Header Bar
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border(
              bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 18 : 32,
            vertical: isSmall ? 14 : 22,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overview',
                      style: GoogleFonts.inter(
                        fontSize: isSmall ? 18 : 26,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.6,
                      ),
                    ),
                    if (!isSmall) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Here is your business summary today.',
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Styled Date Pill & Refresh Button Circle
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isSmall)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const HugeIcon(
                            icon: AppIcons.CALENDARICON,
                            color: Color(0xFF64748B),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatDate(DateTime.now()),
                            style: GoogleFonts.inter(
                              color: const Color(0xFF334155),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (!isSmall) const SizedBox(width: 12),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Color(AppColors.PRIMARY),
                        size: 18,
                      ),
                      tooltip: 'Refresh Dashboard',
                      onPressed: () => controller.refreshDashboardData(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Desktop Screen Adaptive Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isSmall ? 14 : 28,
              isSmall ? 14 : 24,
              isSmall ? 14 : 28,
              isSmall ? 12 : 20,
            ),
            child: Column(
              children: [
                // Metrics Row (fixed compact height)
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        'Total Income',
                        AppIcons.TOTALINCOMEICON,
                        const Color(AppColors.PRIMARY),
                        controller.totalIncome,
                        isCurrency: true,
                        isSmall: isSmall,
                      ),
                    ),
                    SizedBox(width: isSmall ? 8 : 16),
                    Expanded(
                      child: _buildMetricCard(
                        'Brands',
                        AppIcons.BRANDSCOUNTICON,
                        const Color(AppColors.SECONDAY),
                        controller.brandCount,
                        isSmall: isSmall,
                      ),
                    ),
                    SizedBox(width: isSmall ? 8 : 16),
                    Expanded(
                      child: _buildMetricCard(
                        'Categories',
                        AppIcons.CATEGORYCOUNTICON,
                        const Color(AppColors.INFO),
                        controller.categoryCount,
                        isSmall: isSmall,
                      ),
                    ),
                    SizedBox(width: isSmall ? 8 : 16),
                    Expanded(
                      child: _buildMetricCard(
                        'Suppliers',
                        AppIcons.SUPPLIERCOUNTICON,
                        const Color(AppColors.WARNING),
                        controller.supplierCount,
                        isSmall: isSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Suppliers and Live Orders Row (adapts dynamically based on running screen size)
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildSuppliersTable(isSmall: isSmall),
                      ),
                      SizedBox(width: isSmall ? 8 : 16),
                      Expanded(
                        flex: 2,
                        child: _buildOrderHistoryTable(isSmall: isSmall),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Out of Stock Table (adapts to remaining screen height down to bottom)
                Expanded(
                  flex: 4,
                  child: _buildOutOfStockTable(isSmall: isSmall),
                ),
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
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(AppColors.PRIMARY).withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: isActive ? const Color(AppColors.PRIMARY) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _onMenuSelected(title),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                HugeIcon(
                  icon: icon,
                  color: isActive
                      ? Colors.white
                      : const Color(AppColors.TEXTSECONDARY),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      color: isActive
                          ? Colors.white
                          : const Color(AppColors.TEXTSECONDARY),
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 13.5,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMenu(String title, {int tabIndex = 0}) {
    setState(() {
      _brandSupplierTabIndex = tabIndex;
    });
    _onMenuSelected(title, resetTab: false);
  }

  void _onMenuSelected(String title, {bool resetTab = true}) {
    setState(() {
      if (resetTab && title == 'Brands / Suppliers') {
        _brandSupplierTabIndex = 0;
      }
      _selectedMenu = title;
    });
    if (title == 'Dashboard') {
      controller.refreshDashboardData();
    } else if (title == 'Stocks') {
      if (Get.isRegistered<ProductController>()) {
        Get.find<ProductController>().fetchProducts();
      }
    } else if (title == 'Purchase') {
      if (Get.isRegistered<PurchaseController>()) {
        Get.find<PurchaseController>().fetchPurchases();
      }
    } else if (title == 'Brands / Suppliers') {
      if (Get.isRegistered<BrandSupplierCategoryController>()) {
        Get.find<BrandSupplierCategoryController>().refreshAll();
      }
    } else if (title == 'Invoice / Bill') {
      if (Get.isRegistered<InvoiceBillController>()) {
        Get.find<InvoiceBillController>().refreshProducts();
      }
    } else if (title == 'New Order' ||
        title == 'Live / History' ||
        title == 'Orders') {
      if (Get.isRegistered<OrdersController>()) {
        Get.find<OrdersController>().fetchOrders();
      }
    }
  }

  Widget _buildNavExpansionItem(
    String title,
    dynamic icon,
    List<String> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
          child: Row(
            children: [
              HugeIcon(
                icon: icon,
                color: const Color(
                  AppColors.TEXTSECONDARY,
                ).withValues(alpha: 0.8),
                size: 19,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(
                      AppColors.TEXTPRIMARY,
                    ).withValues(alpha: 0.85),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: const Color(
                  AppColors.TEXTSECONDARY,
                ).withValues(alpha: 0.7),
                size: 18,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 23, bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
            ),
          ),
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children.map((e) {
              bool isActive = _selectedMenu == e;
              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(AppColors.PRIMARY)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(
                              AppColors.PRIMARY,
                            ).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => _onMenuSelected(e),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: isActive ? 5 : 4,
                            height: isActive ? 5 : 4,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white
                                  : const Color(
                                      AppColors.TEXTSECONDARY,
                                    ).withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e,
                              style: GoogleFonts.inter(
                                color: isActive
                                    ? Colors.white
                                    : const Color(AppColors.TEXTSECONDARY),
                                fontSize: 13,
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    dynamic icon,
    Color color,
    RxInt rxValue, {
    bool isCurrency = false,
    bool isSmall = false,
  }) {
    final bgColor = const Color(AppColors.WHITE);
    final textColorPrimary = const Color(AppColors.TEXTPRIMARY);
    final textColorSecondary = const Color(AppColors.TEXTSECONDARY);
    final iconBgColor = color.withValues(alpha: 0.12);
    final iconColor = color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: HugeIcon(icon: icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: textColorSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Obx(() {
                  if (rxValue.value == 0 && controller.isLoading.value) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  final value = rxValue.value;
                  final displayValue = isCurrency
                      ? '₹$value'
                      : value.toString();
                  return Text(
                    displayValue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: textColorPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(
    String title, {
    VoidCallback? onViewAll,
    bool isSmall = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isSmall ? 13 : 18,
              fontWeight: FontWeight.w800,
              color: const Color(AppColors.TEXTPRIMARY),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(AppColors.PRIMARY).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: onViewAll ?? () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isSmall ? 8 : 14,
                vertical: isSmall ? 5 : 8,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'View All',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(AppColors.PRIMARY),
                fontWeight: FontWeight.w700,
                fontSize: isSmall ? 10 : 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuppliersTable({bool isSmall = false}) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 20),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(isSmall ? 14 : 24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            'Recent Suppliers',
            onViewAll: () => _navigateToMenu('Brands / Suppliers', tabIndex: 1),
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 10 : 16),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 8 : 14,
              vertical: isSmall ? 8 : 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (!isSmall)
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Address',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(AppColors.TEXTSECONDARY),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Contact',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox.shrink(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.suppliers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final suppliers = controller.suppliers;
              if (suppliers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: AppIcons.SUPPLIERCOUNTICON,
                        color: const Color(
                          AppColors.TEXTSECONDARY,
                        ).withValues(alpha: 0.4),
                        size: isSmall ? 24 : 36,
                      ),
                      SizedBox(height: isSmall ? 6 : 12),
                      Text(
                        'No suppliers found',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(AppColors.TEXTSECONDARY),
                          fontWeight: FontWeight.w600,
                          fontSize: isSmall ? 11 : 14,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final displaySuppliers = suppliers.take(5).toList();
              return ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: displaySuppliers.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  final s = displaySuppliers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            s.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(AppColors.TEXTPRIMARY),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (!isSmall)
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Text(
                                s.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(AppColors.TEXTSECONDARY),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _buildContactChip(s.contact1.toString()),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _buildSupplierStatusBadge(
                              s.status,
                              isSmall: isSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildContactChip(String number) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HugeIcon(
            icon: AppIcons.PHONEICON,
            color: Color(AppColors.TEXTSECONDARY),
            size: 14,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              number,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(AppColors.TEXTSECONDARY),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierStatusBadge(bool status, {bool isSmall = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 6 : 10,
        vertical: isSmall ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: status ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: status ? const Color(0xFF86EFAC) : const Color(0xFFCBD5E1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isSmall ? 4 : 6,
            height: isSmall ? 4 : 6,
            decoration: BoxDecoration(
              color: status ? const Color(0xFF16A34A) : const Color(0xFF64748B),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: isSmall ? 4 : 6),
          Text(
            status
                ? (isSmall ? 'OK' : 'Active')
                : (isSmall ? 'Off' : 'Inactive'),
            style: GoogleFonts.plusJakartaSans(
              color: status ? const Color(0xFF16A34A) : const Color(0xFF64748B),
              fontSize: isSmall ? 9 : 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistoryTable({bool isSmall = false}) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 20),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(isSmall ? 14 : 24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            'Live Orders',
            onViewAll: () => _navigateToMenu('Live / History'),
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 10 : 16),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 8 : 14,
              vertical: isSmall ? 8 : 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Customer',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (!isSmall)
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Date',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(AppColors.TEXTSECONDARY),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Amount',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox.shrink(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.recentOrders.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              final orders = controller.recentOrders;
              if (orders.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: AppIcons.ORDERICON,
                        color: const Color(
                          AppColors.TEXTSECONDARY,
                        ).withValues(alpha: 0.4),
                        size: isSmall ? 24 : 36,
                      ),
                      SizedBox(height: isSmall ? 6 : 12),
                      Text(
                        'No live orders found',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(AppColors.TEXTSECONDARY),
                          fontWeight: FontWeight.w600,
                          fontSize: isSmall ? 11 : 14,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final displayOrders = orders.take(5).toList();
              return ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: displayOrders.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  final o = displayOrders[index];
                  final statusLower = o.status.toLowerCase();
                  final statusBg = statusLower == 'ongoing'
                      ? const Color(AppColors.PRIMARY).withValues(alpha: 0.1)
                      : const Color(AppColors.WARNING).withValues(alpha: 0.1);
                  final statusText = statusLower == 'ongoing'
                      ? const Color(AppColors.PRIMARY)
                      : const Color(AppColors.WARNING);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            o.order.customerName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(AppColors.TEXTPRIMARY),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (!isSmall)
                          Expanded(
                            flex: 2,
                            child: Text(
                              _formatDate(o.order.date),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(AppColors.TEXTSECONDARY),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '₹${o.amount}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(AppColors.TEXTPRIMARY),
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                o.status,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  color: statusText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildOutOfStockTable({bool isSmall = false}) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 12 : 20),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(isSmall ? 14 : 24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(
            'Out of Stock Products',
            onViewAll: () => _navigateToMenu('Stocks'),
            isSmall: isSmall,
          ),
          SizedBox(height: isSmall ? 10 : 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double minWidth = 860.0;
                final double tableWidth = constraints.maxWidth < minWidth
                    ? minWidth
                    : constraints.maxWidth;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Product Name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Category',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Brand',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Quality',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Buy Price',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Sell Price',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Profit',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Action',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: const Color(AppColors.TEXTSECONDARY),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox.shrink(),
                        Expanded(
                          child: Obx(() {
                            if (controller.isLoading.value &&
                                controller.outOfStockProducts.isEmpty) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final products = controller.outOfStockProducts;
                            if (products.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    HugeIcon(
                                      icon: AppIcons.INVENTORYICON,
                                      color: const Color(
                                        AppColors.TEXTSECONDARY,
                                      ).withValues(alpha: 0.4),
                                      size: isSmall ? 24 : 36,
                                    ),
                                    SizedBox(height: isSmall ? 6 : 12),
                                    Text(
                                      'No products are out of stock',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(
                                          AppColors.TEXTSECONDARY,
                                        ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: isSmall ? 11 : 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            final displayProducts = products.take(5).toList();
                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemCount: displayProducts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    height: 1,
                                    color: Color(0xFFF1F5F9),
                                  ),
                              itemBuilder: (context, index) {
                                final p = displayProducts[index];
                                final profit = p.sellPrice - p.buyPrice;
                                final isRefurbish = p.quality
                                    .toLowerCase()
                                    .contains(
                                      'refurbish',
                                    );
                                final qualityColor = isRefurbish
                                    ? const Color(AppColors.WARNING)
                                    : const Color(AppColors.INFO);
                                final qualityBg = isRefurbish
                                    ? const Color(
                                        AppColors.WARNING,
                                      ).withValues(alpha: 0.12)
                                    : const Color(
                                        AppColors.INFO,
                                      ).withValues(alpha: 0.12);

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          p.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(
                                              AppColors.TEXTPRIMARY,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          controller.getCategoryName(p),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(
                                              AppColors.TEXTSECONDARY,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          controller.getBrandName(p),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(
                                              AppColors.TEXTPRIMARY,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: qualityBg,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              p.quality,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                    color: qualityColor,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '₹${p.buyPrice}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(
                                              AppColors.TEXTSECONDARY,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '₹${p.sellPrice}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(
                                              AppColors.TEXTPRIMARY,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '₹$profit',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color(
                                              AppColors.SUCCESS,
                                            ),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            icon: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  AppColors.PRIMARY,
                                                ).withValues(alpha: 0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const HugeIcon(
                                                icon: AppIcons.EDITICON,
                                                color: Color(AppColors.PRIMARY),
                                                size: 16,
                                              ),
                                            ),
                                            onPressed: () {
                                              _onMenuSelected('Stocks');
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
