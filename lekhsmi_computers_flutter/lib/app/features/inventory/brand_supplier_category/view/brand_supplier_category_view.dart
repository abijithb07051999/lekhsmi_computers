import 'package:flutter/material.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_icons.dart';
import 'package:lekhsmi_computers_flutter/core/utils/responsive_utils.dart';
import '../controller/brand_supplier_category_controller.dart';
import 'brand_supplier_category_mobile_view.dart';

class BrandSupplierCategoryView extends StatefulWidget {
  final int initialTabIndex;
  const BrandSupplierCategoryView({super.key, this.initialTabIndex = 0});

  @override
  State<BrandSupplierCategoryView> createState() => _BrandSupplierCategoryViewState();
}

class _BrandSupplierCategoryViewState extends State<BrandSupplierCategoryView> {
  final controller = Get.put(BrandSupplierCategoryController());
  late int _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
  }

  @override
  void didUpdateWidget(covariant BrandSupplierCategoryView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTabIndex != oldWidget.initialTabIndex) {
      setState(() {
        _selectedTabIndex = widget.initialTabIndex;
      });
    }
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
    if (ResponsiveUtils.isPhone(context)) {
      return BrandSupplierCategoryMobileView(initialTabIndex: _selectedTabIndex);
    }
    return Column(
      children: [
        // Premium Enterprise Top Header Bar (matches dashboard_view.dart)
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border(
              bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brand, Supplier & Category',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage your inventory classifications, vendors, and brands in one unified workspace.',
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Styled Date Pill & Refresh Button Circle
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  const SizedBox(width: 12),
                  Container(
                    width: 40,
                    height: 40,
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
                        size: 20,
                      ),
                      tooltip: 'Refresh Data',
                      onPressed: () => controller.refreshAll(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Segmented Tabs Header
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 28, 8),
          child: Row(
            children: [
              _buildTabButton(0, 'Brands', AppIcons.BRANDSCOUNTICON, controller.brands),
              const SizedBox(width: 12),
              _buildTabButton(1, 'Suppliers', AppIcons.SUPPLIERCOUNTICON, controller.suppliers),
              const SizedBox(width: 12),
              _buildTabButton(2, 'Categories', AppIcons.CATEGORYCOUNTICON, controller.categories),
            ],
          ),
        ),

        // Tab Content Area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
            child: Builder(
              builder: (context) {
                switch (_selectedTabIndex) {
                  case 0:
                    return _buildBrandsSection();
                  case 1:
                    return _buildSuppliersSection();
                  case 2:
                    return _buildCategoriesSection();
                  default:
                    return _buildBrandsSection();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(int index, String title, dynamic icon, RxList list) {
    final isSelected = _selectedTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedTabIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(AppColors.PRIMARY)
              : const Color(AppColors.WHITE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(AppColors.PRIMARY)
                : const Color(0xFFE2E8F0),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(AppColors.PRIMARY).withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          children: [
            HugeIcon(
              icon: icon,
              color: isSelected
                  ? Colors.white
                  : const Color(AppColors.TEXTSECONDARY),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                color: isSelected
                    ? Colors.white
                    : const Color(AppColors.TEXTPRIMARY),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.2)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${list.length}',
                    style: GoogleFonts.inter(
                      color: isSelected
                          ? Colors.white
                          : const Color(AppColors.TEXTSECONDARY),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }



  // ---------------------------------------------------------------------------
  // BRANDS SECTION
  // ---------------------------------------------------------------------------
  Widget _buildBrandsSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(24),
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
        children: [
          // Action bar
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: _buildSearchBar(
                    hintText: 'Search brands by name...',
                    onChanged: (val) => controller.brandSearchQuery.value = val,
                  ),
                ),
                const SizedBox(width: 16),
                _buildAddButton(
                  title: 'Add New Brand',
                  onTap: () => BrandSupplierCategoryDialogs.showBrandDialog(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          // Table Header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'No',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Brand Name',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Action',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Table List
          Expanded(
            child: Obx(() => controller.isLoadingBrands.value
                ? const Center(child: CircularProgressIndicator())
                : controller.filteredBrands.isEmpty
                    ? _buildEmptyState('No brands found. Click "Add New Brand" to create one.')
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
                        itemCount: controller.filteredBrands.length,
                        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        itemBuilder: (context, index) {
                          final b = controller.filteredBrands[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${index + 1}',
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTSECONDARY),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    b.name,
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTPRIMARY),
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: _buildStatusBadge(b.status),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: _buildEditIconButton(
                                      onTap: () => BrandSupplierCategoryDialogs.showBrandDialog(context, brand: b),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SUPPLIERS SECTION
  // ---------------------------------------------------------------------------
  Widget _buildSuppliersSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(24),
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
        children: [
          // Action bar
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: _buildSearchBar(
                    hintText: 'Search suppliers by name, phone, address...',
                    onChanged: (val) => controller.supplierSearchQuery.value = val,
                  ),
                ),
                const SizedBox(width: 16),
                _buildAddButton(
                  title: 'Add New Supplier',
                  onTap: () => BrandSupplierCategoryDialogs.showSupplierDialog(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          // Table Header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'No',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Supplier Name',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Address',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Primary Phone',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Secondary Phone',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: GoogleFonts.inter(
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
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Table List
          Expanded(
            child: Obx(() => controller.isLoadingSuppliers.value
                ? const Center(child: CircularProgressIndicator())
                : controller.filteredSuppliers.isEmpty
                    ? _buildEmptyState('No suppliers found. Click "Add New Supplier" to create one.')
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
                        itemCount: controller.filteredSuppliers.length,
                        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        itemBuilder: (context, index) {
                          final s = controller.filteredSuppliers[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${index + 1}',
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTSECONDARY),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    s.name,
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTPRIMARY),
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    s.address,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTSECONDARY),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${s.contact1}',
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.INFO),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    s.contact2 == 0 ? '--' : '${s.contact2}',
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTSECONDARY),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: _buildStatusBadge(s.status),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: _buildEditIconButton(
                                      onTap: () => BrandSupplierCategoryDialogs.showSupplierDialog(context, supplier: s),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CATEGORIES SECTION
  // ---------------------------------------------------------------------------
  Widget _buildCategoriesSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(24),
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
        children: [
          // Action bar
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: _buildSearchBar(
                    hintText: 'Search categories by name...',
                    onChanged: (val) => controller.categorySearchQuery.value = val,
                  ),
                ),
                const SizedBox(width: 16),
                _buildAddButton(
                  title: 'Add New Category',
                  onTap: () => BrandSupplierCategoryDialogs.showCategoryDialog(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          // Table Header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'No',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'Category Name',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Action',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.inter(
                      color: const Color(AppColors.TEXTSECONDARY),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Table List
          Expanded(
            child: Obx(() => controller.isLoadingCategories.value
                ? const Center(child: CircularProgressIndicator())
                : controller.filteredCategories.isEmpty
                    ? _buildEmptyState('No categories found. Click "Add New Category" to create one.')
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
                        itemCount: controller.filteredCategories.length,
                        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        itemBuilder: (context, index) {
                          final c = controller.filteredCategories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${index + 1}',
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTSECONDARY),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    c.name,
                                    style: GoogleFonts.inter(
                                      color: const Color(AppColors.TEXTPRIMARY),
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: _buildStatusBadge(c.status),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: _buildEditIconButton(
                                      onTap: () => BrandSupplierCategoryDialogs.showCategoryDialog(context, category: c),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER COMPONENTS
  // ---------------------------------------------------------------------------

  Widget _buildSearchBar({required String hintText, required Function(String) onChanged}) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        onChanged: onChanged,
        style: GoogleFonts.inter(
          color: const Color(AppColors.TEXTPRIMARY),
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: const Color(AppColors.HINTTEXT),
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(AppColors.TEXTSECONDARY),
            size: 18,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildAddButton({required String title, required VoidCallback onTap}) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(AppColors.PRIMARY),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const HugeIcon(icon: AppIcons.ADDICON, color: Colors.white, size: 18),
        label: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
          ),
        ),
      ),
    );
  }

  Widget _buildEditIconButton({required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      tooltip: 'Edit Item',
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const HugeIcon(
          icon: AppIcons.EDITICON,
          color: Color(AppColors.PRIMARY),
          size: 16,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: (status
                ? const Color(AppColors.SUCCESS)
                : const Color(AppColors.TEXTSECONDARY))
            .withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status ? 'Active' : 'Inactive',
        style: GoogleFonts.inter(
          color: status
              ? const Color(AppColors.SUCCESS)
              : const Color(AppColors.TEXTSECONDARY),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HugeIcon(
            icon: AppIcons.INVENTORYICON,
            color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.4),
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(AppColors.TEXTSECONDARY),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BrandSupplierCategoryDialogs {
  // ---------------------------------------------------------------------------
  // 1. BRAND DIALOG - "INDIGO HARDWARE BRAND CARD" DESIGN (ADD vs EDIT)
  // ---------------------------------------------------------------------------
  static void showBrandDialog(BuildContext context, {Brand? brand}) {
    final controller = Get.find<BrandSupplierCategoryController>();
    final nameCtrl = TextEditingController(text: brand?.name ?? '');
    bool status = brand?.status ?? true;
    final isEdit = brand != null;
    const accentColor = Color(0xFF4F46E5); // Deep Indigo

    Get.dialog(
      StatefulBuilder(
        builder: (context, setDlgState) {
          return _buildDialogShell(
            context: context,
            accentColor: accentColor,
            header: _buildDialogHeader(
              accentColor: accentColor,
              icon: AppIcons.BRANDSCOUNTICON,
              badgeText: isEdit ? 'EDITING BRAND' : 'NEW BRAND REGISTRATION',
              title: isEdit ? 'Update Brand: ${brand.name}' : 'Register Brand',
              subtitle: isEdit
                  ? 'Modify brand title and catalog visibility status.'
                  : 'Add a new hardware brand to categorize inventory products.',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indigo Brand Preview Banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.12),
                        accentColor.withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accentColor.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.verified_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isEdit ? 'Catalog Brand Entry #id-${brand.id ?? "active"}' : 'Catalog Brand Identity',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: accentColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isEdit
                                  ? 'Changes apply instantly to product filters.'
                                  : 'Will be selectable when adding stock items.',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.5,
                                color: const Color(AppColors.TEXTSECONDARY),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildDialogTextField(
                  label: 'Brand Name',
                  hintText: 'e.g. Asus, Logitech, Intel, Samsung',
                  controller: nameCtrl,
                  prefixIcon: Icons.branding_watermark_rounded,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 20),
                _buildDialogStatusToggle(
                  value: status,
                  accentColor: accentColor,
                  activeTitle: 'Visible in Catalog',
                  inactiveTitle: 'Hidden from Catalog',
                  onChanged: (val) => setDlgState(() => status = val),
                ),
              ],
            ),
            footer: _buildDialogFooter(
              accentColor: accentColor,
              saveLabel: isEdit ? 'Save Brand Changes' : 'Create Brand',
              onSave: () {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) {
                  AppNotification.warning('Warning', 'Brand name cannot be empty');
                  return;
                }
                if (brand == null) {
                  controller.addBrand(Brand(name: name, status: status));
                } else {
                  brand.name = name;
                  brand.status = status;
                  controller.updateBrand(brand);
                }
              },
            ),
          );
        },
      ),
      barrierDismissible: true,
    );
  }

  // ---------------------------------------------------------------------------
  // 2. SUPPLIER DIALOG - "EMERALD CORPORATE VENDOR SHEET" (ADD vs EDIT)
  // ---------------------------------------------------------------------------
  static void showSupplierDialog(BuildContext context, {Supplier? supplier}) {
    final controller = Get.find<BrandSupplierCategoryController>();
    final nameCtrl = TextEditingController(text: supplier?.name ?? '');
    final addressCtrl = TextEditingController(text: supplier?.address ?? '');
    final contact1Ctrl = TextEditingController(
      text: supplier != null ? '${supplier.contact1}' : '',
    );
    final contact2Ctrl = TextEditingController(
      text: (supplier != null && supplier.contact2 != 0) ? '${supplier.contact2}' : '',
    );
    bool status = supplier?.status ?? true;
    final isEdit = supplier != null;
    const accentColor = Color(0xFF059669); // Rich Emerald Green

    Get.dialog(
      StatefulBuilder(
        builder: (context, setDlgState) {
          final isPhone = ResponsiveUtils.isPhone(context);

          return _buildDialogShell(
            context: context,
            accentColor: accentColor,
            header: _buildDialogHeader(
              accentColor: accentColor,
              icon: AppIcons.SUPPLIERCOUNTICON,
              badgeText: isEdit ? 'VENDOR PROFILE UPDATE' : 'VENDOR ONBOARDING',
              title: isEdit ? 'Edit Partner: ${supplier.name}' : 'Onboard Supplier',
              subtitle: isEdit
                  ? 'Update partner contacts and office billing location.'
                  : 'Register a new supplier/vendor partner with contact numbers.',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Emerald Vendor Partner Banner
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accentColor.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.handshake_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isEdit ? 'Authorized Supply Partner' : 'New Supply Partner Registration',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: accentColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isEdit
                                  ? 'Purchase orders linked to this vendor.'
                                  : 'Verify contact digits before onboarding.',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.5,
                                color: const Color(AppColors.TEXTSECONDARY),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildDialogTextField(
                  label: 'Supplier / Company Name',
                  hintText: 'e.g. Tech Distribution Pvt Ltd',
                  controller: nameCtrl,
                  prefixIcon: Icons.business_rounded,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 16),
                // Responsive phone layout (stacked on phone to prevent overflow!)
                if (isPhone) ...[
                  _buildDialogTextField(
                    label: 'Primary Phone (Required)',
                    hintText: 'e.g. 9876543210',
                    controller: contact1Ctrl,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_rounded,
                    accentColor: accentColor,
                  ),
                  const SizedBox(height: 14),
                  _buildDialogTextField(
                    label: 'Secondary Phone (Optional)',
                    hintText: 'e.g. 0471234567',
                    controller: contact2Ctrl,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone_android_rounded,
                    accentColor: accentColor,
                  ),
                ] else
                  Row(
                    children: [
                      Expanded(
                        child: _buildDialogTextField(
                          label: 'Primary Phone (Required)',
                          hintText: 'e.g. 9876543210',
                          controller: contact1Ctrl,
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icons.phone_rounded,
                          accentColor: accentColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDialogTextField(
                          label: 'Secondary Phone (Optional)',
                          hintText: 'e.g. 0471234567',
                          controller: contact2Ctrl,
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icons.phone_android_rounded,
                          accentColor: accentColor,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                _buildDialogTextField(
                  label: 'Office / Billing Address',
                  hintText: 'Enter complete address including city and pin code',
                  controller: addressCtrl,
                  maxLines: 2,
                  prefixIcon: Icons.location_on_rounded,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 20),
                _buildDialogStatusToggle(
                  value: status,
                  accentColor: accentColor,
                  activeTitle: 'Active Vendor Partner',
                  inactiveTitle: 'Inactive / Suspended Vendor',
                  onChanged: (val) => setDlgState(() => status = val),
                ),
              ],
            ),
            footer: _buildDialogFooter(
              accentColor: accentColor,
              saveLabel: isEdit ? 'Update Vendor Profile' : 'Register Vendor',
              onSave: () {
                final name = nameCtrl.text.trim();
                final c1 = int.tryParse(contact1Ctrl.text.trim()) ?? 0;
                final c2 = int.tryParse(contact2Ctrl.text.trim()) ?? 0;
                final address = addressCtrl.text.trim();

                if (name.isEmpty) {
                  AppNotification.warning('Warning', 'Supplier name cannot be empty');
                  return;
                }
                if (c1 == 0) {
                  AppNotification.warning('Warning', 'Please enter a valid primary contact number');
                  return;
                }

                if (supplier == null) {
                  controller.addSupplier(
                    Supplier(
                      name: name,
                      address: address,
                      contact1: c1,
                      contact2: c2,
                      status: status,
                    ),
                  );
                } else {
                  supplier.name = name;
                  supplier.address = address;
                  supplier.contact1 = c1;
                  supplier.contact2 = c2;
                  supplier.status = status;
                  controller.updateSupplier(supplier);
                }
              },
            ),
          );
        },
      ),
      barrierDismissible: true,
    );
  }

  // ---------------------------------------------------------------------------
  // 3. CATEGORY DIALOG - "VIBRANT AMBER/CORAL TAG STUDIO" (ADD vs EDIT)
  // ---------------------------------------------------------------------------
  static void showCategoryDialog(BuildContext context, {Category? category}) {
    final controller = Get.find<BrandSupplierCategoryController>();
    final nameCtrl = TextEditingController(text: category?.name ?? '');
    bool status = category?.status ?? true;
    final isEdit = category != null;
    const accentColor = Color(0xFFEA580C); // Vibrant Coral Orange

    Get.dialog(
      StatefulBuilder(
        builder: (context, setDlgState) {
          final liveName = nameCtrl.text.trim().isEmpty ? 'New Category Tag' : nameCtrl.text.trim();

          return _buildDialogShell(
            context: context,
            accentColor: accentColor,
            header: _buildDialogHeader(
              accentColor: accentColor,
              icon: AppIcons.CATEGORYCOUNTICON,
              badgeText: isEdit ? 'CATEGORY MODIFICATION' : 'NEW CATEGORY SETUP',
              title: isEdit ? 'Edit Category: ${category.name}' : 'Create Category',
              subtitle: isEdit
                  ? 'Rename classification tag or toggle filter status.'
                  : 'Define a new product classification tag for your catalog.',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Interactive Tag Preview Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'LIVE TAG PREVIEW',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w800,
                              fontSize: 10.5,
                              letterSpacing: 0.8,
                              color: accentColor,
                            ),
                          ),
                          Icon(Icons.auto_awesome_rounded, color: accentColor, size: 16),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: accentColor,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.category_rounded, color: Colors.white, size: 15),
                                const SizedBox(width: 8),
                                Text(
                                  liveName,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    status ? 'ACTIVE' : 'INACTIVE',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 9.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildDialogTextField(
                  label: 'Category Title',
                  hintText: 'e.g. Laptops, Processors, Keyboards, Displays',
                  controller: nameCtrl,
                  prefixIcon: Icons.label_important_rounded,
                  accentColor: accentColor,
                  onChanged: (_) => setDlgState(() {}),
                ),
                const SizedBox(height: 20),
                _buildDialogStatusToggle(
                  value: status,
                  accentColor: accentColor,
                  activeTitle: 'Active Filter Tag',
                  inactiveTitle: 'Disabled Filter',
                  onChanged: (val) => setDlgState(() => status = val),
                ),
              ],
            ),
            footer: _buildDialogFooter(
              accentColor: accentColor,
              saveLabel: isEdit ? 'Save Category' : 'Create Category',
              onSave: () {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) {
                  AppNotification.warning('Warning', 'Category name cannot be empty');
                  return;
                }
                if (category == null) {
                  controller.addCategory(Category(name: name, status: status));
                } else {
                  category.name = name;
                  category.status = status;
                  controller.updateCategory(category);
                }
              },
            ),
          );
        },
      ),
      barrierDismissible: true,
    );
  }

  // ---------------------------------------------------------------------------
  // SHARED RESPONSIVE DIALOG CONTAINER (ZERO KEYBOARD & HORIZONTAL OVERFLOW)
  // ---------------------------------------------------------------------------
  static Widget _buildDialogShell({
    required BuildContext context,
    required Color accentColor,
    required Widget header,
    required Widget content,
    required Widget footer,
  }) {
    final isPhone = ResponsiveUtils.isPhone(context);
    final maxH = MediaQuery.of(context).size.height * (isPhone ? 0.90 : 0.85);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isPhone ? 12 : 32,
        vertical: 16,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 540,
          maxHeight: maxH,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(AppColors.WHITE),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: accentColor.withValues(alpha: 0.25), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Fixed Header Area
              header,
              Divider(height: 1, color: accentColor.withValues(alpha: 0.15)),
              // 2. Scrollable Body Content (Flexibly scrolls when keyboard opens!)
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(isPhone ? 18 : 26),
                  child: content,
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              // 3. Fixed Footer Actions Area
              footer,
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildDialogHeader({
    required Color accentColor,
    required dynamic icon,
    required String badgeText,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 20, 18),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.04),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: accentColor.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: HugeIcon(
                icon: icon,
                color: accentColor,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badgeText,
                    style: GoogleFonts.inter(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: const Color(AppColors.TEXTPRIMARY),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    color: const Color(AppColors.TEXTSECONDARY),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            tooltip: 'Close',
            icon: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Color(AppColors.TEXTSECONDARY),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDialogTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData prefixIcon,
    required Color accentColor,
    TextInputType? keyboardType,
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: const Color(AppColors.TEXTPRIMARY),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          onChanged: onChanged,
          style: GoogleFonts.inter(
            color: const Color(AppColors.TEXTPRIMARY),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              color: const Color(AppColors.HINTTEXT),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            prefixIcon: Icon(prefixIcon, color: accentColor, size: 20),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: accentColor,
                width: 1.8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildDialogStatusToggle({
    required bool value,
    required Color accentColor,
    required String activeTitle,
    required String inactiveTitle,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: value ? accentColor.withValues(alpha: 0.05) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? accentColor.withValues(alpha: 0.4) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (value ? accentColor : const Color(AppColors.TEXTSECONDARY)).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              value ? Icons.check_circle_rounded : Icons.pause_circle_rounded,
              color: value ? accentColor : const Color(AppColors.TEXTSECONDARY),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value ? activeTitle : inactiveTitle,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: value ? accentColor : const Color(AppColors.TEXTPRIMARY),
                  ),
                ),
                Text(
                  value ? 'Selectable across inventory workflows' : 'Temporarily suspended from selections',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: const Color(AppColors.TEXTSECONDARY),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: accentColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  static Widget _buildDialogFooter({
    required Color accentColor,
    required String saveLabel,
    required VoidCallback onSave,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(AppColors.TEXTPRIMARY),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
            label: Text(
              saveLabel,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
