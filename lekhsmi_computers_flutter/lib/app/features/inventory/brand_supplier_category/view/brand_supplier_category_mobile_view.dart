import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_icons.dart';
import '../controller/brand_supplier_category_controller.dart';
import 'brand_supplier_category_view.dart';

class BrandSupplierCategoryMobileView extends StatefulWidget {
  final int initialTabIndex;

  const BrandSupplierCategoryMobileView({
    super.key,
    this.initialTabIndex = 0,
  });

  @override
  State<BrandSupplierCategoryMobileView> createState() =>
      _BrandSupplierCategoryMobileViewState();
}

class _BrandSupplierCategoryMobileViewState
    extends State<BrandSupplierCategoryMobileView> {
  final controller = Get.put(BrandSupplierCategoryController());
  late int _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
  }

  @override
  void didUpdateWidget(covariant BrandSupplierCategoryMobileView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialTabIndex != oldWidget.initialTabIndex) {
      setState(() {
        _selectedTabIndex = widget.initialTabIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── ELITE MOBILE HEADER BAR ──────────────────────────────────────────
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Taxonomy & Partners',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Manage brands, categories, and suppliers',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => controller.refreshAll(),
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Color(AppColors.PRIMARY),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── ELITE SCROLLABLE TABS HEADER ─────────────────────────────────────
        Container(
          width: double.infinity,
          color: const Color(0xFFF8FAFC),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                _buildEliteTabButton(
                  index: 0,
                  title: 'Brand Catalog',
                  icon: AppIcons.BRANDSCOUNTICON,
                  list: controller.brands,
                ),
                const SizedBox(width: 10),
                _buildEliteTabButton(
                  index: 1,
                  title: 'Supplier Network',
                  icon: AppIcons.SUPPLIERCOUNTICON,
                  list: controller.suppliers,
                ),
                const SizedBox(width: 10),
                _buildEliteTabButton(
                  index: 2,
                  title: 'Categories',
                  icon: AppIcons.CATEGORYCOUNTICON,
                  list: controller.categories,
                ),
              ],
            ),
          ),
        ),

        // ── TAB CONTENT AREA ────────────────────────────────────────────────
        Expanded(
          child: Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Builder(
              builder: (context) {
                switch (_selectedTabIndex) {
                  case 0:
                    return Column(
                      children: [
                        _buildEliteSearchBar(
                          hintText: 'Search brand catalog...',
                          onChanged: (val) =>
                              controller.brandSearchQuery.value = val,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: _buildEliteAddButton(
                            title: 'Register New Brand',
                            onTap: () => BrandSupplierCategoryDialogs
                                .showBrandDialog(context),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(child: _buildEliteBrandList()),
                      ],
                    );
                  case 1:
                    return Column(
                      children: [
                        _buildEliteSearchBar(
                          hintText: 'Search supplier network...',
                          onChanged: (val) =>
                              controller.supplierSearchQuery.value = val,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: _buildEliteAddButton(
                            title: 'Onboard New Supplier',
                            onTap: () => BrandSupplierCategoryDialogs
                                .showSupplierDialog(context),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(child: _buildEliteSupplierList()),
                      ],
                    );
                  case 2:
                    return Column(
                      children: [
                        _buildEliteSearchBar(
                          hintText: 'Search categories...',
                          onChanged: (val) =>
                              controller.categorySearchQuery.value = val,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: _buildEliteAddButton(
                            title: 'Create New Category',
                            onTap: () => BrandSupplierCategoryDialogs
                                .showCategoryDialog(context),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(child: _buildEliteCategoryList()),
                      ],
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // ELITE TAB BUTTON
  // ===========================================================================
  Widget _buildEliteTabButton({
    required int index,
    required String title,
    required dynamic icon,
    required RxList list,
  }) {
    final isSelected = _selectedTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedTabIndex = index),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF0F172A)
                : const Color(0xFFE2E8F0),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF475569),
              ),
            ),
            const SizedBox(width: 8),
            Obx(() => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.2)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${list.length}',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color:
                          isSelected ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // ELITE BRAND LIST
  // ===========================================================================
  Widget _buildEliteBrandList() {
    return Obx(() {
      if (controller.isLoadingBrands.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
        );
      }
      if (controller.filteredBrands.isEmpty) {
        return _buildEliteEmptyState(
          'No brands found in catalog.\nRegister a new brand to get started.',
        );
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: controller.filteredBrands.length,
        itemBuilder: (context, index) {
          final b = controller.filteredBrands[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          b.name.isNotEmpty ? b.name[0].toUpperCase() : 'B',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF4F46E5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              b.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 15.5,
                                color: const Color(AppColors.TEXTPRIMARY),
                              ),
                            ),
                            const SizedBox(height: 4),
                            _buildEliteStatusBadge(b.status),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildEliteEditIconButton(
                  onTap: () => BrandSupplierCategoryDialogs.showBrandDialog(
                    context,
                    brand: b,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // ===========================================================================
  // ELITE SUPPLIER LIST
  // ===========================================================================
  Widget _buildEliteSupplierList() {
    return Obx(() {
      if (controller.isLoadingSuppliers.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
        );
      }
      if (controller.filteredSuppliers.isEmpty) {
        return _buildEliteEmptyState(
          'No suppliers found in network.\nOnboard a new supplier to continue.',
        );
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: controller.filteredSuppliers.length,
        itemBuilder: (context, index) {
          final s = controller.filteredSuppliers[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0284C7)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: const HugeIcon(
                              icon: AppIcons.SUPPLIERCOUNTICON,
                              color: Color(0xFF0284C7),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: const Color(AppColors.TEXTPRIMARY),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                _buildEliteStatusBadge(s.status),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    _buildEliteEditIconButton(
                      onTap: () => BrandSupplierCategoryDialogs
                          .showSupplierDialog(context, supplier: s),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 16,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        s.address.isNotEmpty ? s.address : 'No address provided',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildEliteContactChip(s.contact1.toString()),
                    if (s.contact2 != 0)
                      _buildEliteContactChip(s.contact2.toString()),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // ===========================================================================
  // ELITE CATEGORY LIST
  // ===========================================================================
  Widget _buildEliteCategoryList() {
    return Obx(() {
      if (controller.isLoadingCategories.value) {
        return const Center(
          child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
        );
      }
      if (controller.filteredCategories.isEmpty) {
        return _buildEliteEmptyState(
          'No categories found.\nCreate a new category to organize items.',
        );
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: controller.filteredCategories.length,
        itemBuilder: (context, index) {
          final c = controller.filteredCategories[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD97706).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          c.name.isNotEmpty ? c.name[0].toUpperCase() : 'C',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFD97706),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.name,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 15.5,
                                color: const Color(AppColors.TEXTPRIMARY),
                              ),
                            ),
                            const SizedBox(height: 4),
                            _buildEliteStatusBadge(c.status),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildEliteEditIconButton(
                  onTap: () => BrandSupplierCategoryDialogs.showCategoryDialog(
                    context,
                    category: c,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  // ===========================================================================
  // ELITE WIDGET HELPERS
  // ===========================================================================
  Widget _buildEliteSearchBar({
    required String hintText,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        style: GoogleFonts.inter(
          fontSize: 14.5,
          color: const Color(0xFF0F172A),
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF94A3B8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.search_rounded,
              color: Color(0xFF64748B),
              size: 22,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildEliteAddButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0284C7), Color(0xFF38BDF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0284C7).withValues(alpha: 0.3),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_circle_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEliteEditIconButton({required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.edit_rounded,
            size: 18,
            color: Color(AppColors.PRIMARY),
          ),
        ),
      ),
    );
  }

  Widget _buildEliteStatusBadge(bool status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: status
            ? const Color(0xFF10B981).withValues(alpha: 0.12)
            : const Color(0xFFEF4444).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: status ? const Color(0xFF10B981) : const Color(0xFFEF4444),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status ? 'ACTIVE' : 'INACTIVE',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: status ? const Color(0xFF059669) : const Color(0xFFDC2626),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEliteContactChip(String contact) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HugeIcon(
            icon: AppIcons.PHONEICON,
            color: Color(0xFF64748B),
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            contact,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEliteEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.folder_open_rounded,
                size: 48,
                color: Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
