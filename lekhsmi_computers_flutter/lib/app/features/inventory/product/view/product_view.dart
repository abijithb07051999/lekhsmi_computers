import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_icons.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_dropdown.dart';
import 'package:lekhsmi_computers_flutter/app/features/inventory/product/controller/product_controller.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Header Section (White Card Bar)
        _buildTitleSection(),
        // Content Area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
            child: Obx(() {
              return _buildProductsTableSection(context);
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(AppColors.WHITE),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 12,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Products & Stock Inventory',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(AppColors.TEXTPRIMARY),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'PRODUCT CATALOG',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(AppColors.PRIMARY),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 14, color: Color(AppColors.TEXTSECONDARY)),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(DateTime.now()),
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(AppColors.TEXTPRIMARY),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => controller.refreshAll(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(AppColors.WHITE),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(Icons.refresh_rounded, color: Color(AppColors.TEXTPRIMARY), size: 18),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTableSection(BuildContext context) {
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
          // Action Bar
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: _buildSearchBar(
                    hintText: 'Search products by name, category, brand, quality...',
                    onChanged: (val) => controller.searchQuery.value = val,
                  ),
                ),
                const SizedBox(width: 16),
                _buildAddButton(
                  title: 'Add New Product',
                  onTap: () => _showProductDialog(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          // Table Header & Rows with horizontal scroll protection for tablets
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double minWidth = 1080.0;
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
                              Expanded(flex: 1, child: Text('NO', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 4, child: Text('Product', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 3, child: Text('Category', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 2, child: Text('Brand', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 2, child: Text('Quality', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 2, child: Text('Quantity', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 2, child: Text('Buy Price', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 2, child: Text('Sell Price', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 2, child: Text('Profit', maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                              Expanded(flex: 1, child: Text('Action', maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right, style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 12, fontWeight: FontWeight.w700))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Table Rows
                        Expanded(
                          child: controller.isLoadingProducts.value
                              ? const Center(child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)))
                              : controller.filteredProducts.isEmpty
                                  ? _buildEmptyState('No products found. Click "Add New Product" to create one.')
                                  : ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
                                      itemCount: controller.filteredProducts.length,
                                      separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                                      itemBuilder: (context, index) {
                                        final p = controller.filteredProducts[index];
                                        final profit = p.sellPrice - p.buyPrice;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${index + 1}',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                    color: const Color(AppColors.TEXTSECONDARY),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  p.name,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                    color: const Color(AppColors.TEXTPRIMARY),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  controller.getCategoryName(p),
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
                                                  controller.getBrandName(p),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                    color: const Color(AppColors.TEXTPRIMARY),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: _buildQualityText(p.quality),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${p.quantity}',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                    color: const Color(AppColors.TEXTPRIMARY),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  _formatCurrency(p.buyPrice),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                    color: const Color(AppColors.TEXTPRIMARY),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  _formatCurrency(p.sellPrice),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                    color: const Color(AppColors.TEXTPRIMARY),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: _buildProfitText(profit),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: _buildEditIconButton(
                                                    onTap: () => _showProductDialog(context, product: p),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildQualityText(String quality) {
    Color textColor;
    final lower = quality.trim().toLowerCase();
    if (lower.contains('first')) {
      textColor = const Color(0xFF10B981); // Emerald Green
    } else if (lower.contains('second')) {
      textColor = const Color(0xFF0EA5E9); // Cyan Blue
    } else if (lower.contains('refurbished')) {
      textColor = const Color(0xFFF59E0B); // Amber Orange
    } else {
      textColor = const Color(AppColors.PRIMARY);
    }
    return Text(
      quality,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: textColor,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildProfitText(int profit) {
    final isNegative = profit < 0;
    final absVal = profit.abs();
    final formatted = _formatCurrency(absVal);
    return Text(
      isNegative ? '-$formatted' : formatted,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: isNegative ? const Color(0xFFEF4444) : const Color(0xFF10B981),
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  String _formatCurrency(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count == 3 && i != 0) {
        buffer.write(',');
      } else if (count > 3 && (count - 3) % 2 == 0 && i != 0) {
        buffer.write(',');
      }
    }
    return '₹${buffer.toString().split('').reversed.join()}';
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  Widget _buildSearchBar({
    required String hintText,
    required Function(String) onChanged,
  }) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: Color(AppColors.TEXTSECONDARY),
            size: 18,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: GoogleFonts.inter(
                color: const Color(AppColors.TEXTPRIMARY),
                fontSize: 13.5,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.inter(
                  color: const Color(AppColors.TEXTSECONDARY),
                  fontSize: 13.5,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
        label: Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(AppColors.PRIMARY),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildEditIconButton({required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(AppColors.PRIMARY).withValues(alpha: 0.4),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.edit_outlined,
            color: Color(AppColors.PRIMARY),
            size: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 56,
            color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Color(AppColors.TEXTSECONDARY),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ADD / EDIT PRODUCT DIALOG
  // ---------------------------------------------------------------------------
  void _showProductDialog(BuildContext context, {Product? product}) {
    final nameCtrl = TextEditingController(text: product?.name ?? '');
    final quantityCtrl = TextEditingController(
      text: product != null ? '${product.quantity}' : '1',
    );
    final buyPriceCtrl = TextEditingController(
      text: product != null ? '${product.buyPrice}' : '0',
    );
    final sellPriceCtrl = TextEditingController(
      text: product != null ? '${product.sellPrice}' : '0',
    );

    int? selectedCategoryId = product?.categoryId;
    if (selectedCategoryId == null && controller.categories.isNotEmpty) {
      selectedCategoryId = controller.categories.first.id;
    }

    int? selectedBrandId = product?.brandId;
    if (selectedBrandId == null && controller.brands.isNotEmpty) {
      selectedBrandId = controller.brands.first.id;
    }

    String selectedQuality = product?.quality ?? 'First Quality';
    final qualities = ['First Quality', 'Second Hand', 'Refurbished'];
    if (!qualities.contains(selectedQuality)) {
      qualities.add(selectedQuality);
    }

    bool status = product?.status ?? true;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setDlgState) {
          return _buildModernDialogCard(
            title: product == null ? 'Add Product' : 'Edit Product',
            subtitle: product == null
                ? 'Register a new product with category, brand, pricing, and stock details.'
                : 'Update existing product pricing, stock quantity, and quality.',
            icon: AppIcons.PRODUCTADDICON,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDialogTextField(
                  label: 'Product Name / Model',
                  hintText: 'e.g. G15 - 11532U',
                  controller: nameCtrl,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDialogDropdown<int>(
                        label: 'Category',
                        value: selectedCategoryId,
                        items: controller.categories.map((c) {
                          return DropdownMenuItem<int>(
                            value: c.id,
                            child: Text(c.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY))),
                          );
                        }).toList(),
                        onChanged: (val) => setDlgState(() => selectedCategoryId = val),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDialogDropdown<int>(
                        label: 'Brand',
                        value: selectedBrandId,
                        items: controller.brands.map((b) {
                          return DropdownMenuItem<int>(
                            value: b.id,
                            child: Text(b.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY))),
                          );
                        }).toList(),
                        onChanged: (val) => setDlgState(() => selectedBrandId = val),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildDialogDropdown<String>(
                        label: 'Quality',
                        value: selectedQuality,
                        items: qualities.map((q) {
                          return DropdownMenuItem<String>(
                            value: q,
                            child: Text(q, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY))),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setDlgState(() => selectedQuality = val);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildDialogTextField(
                        label: 'Quantity',
                        hintText: 'e.g. 5',
                        controller: quantityCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildDialogTextField(
                        label: 'Buy Price [1 Unit]',
                        hintText: 'e.g. 60000',
                        controller: buyPriceCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDialogTextField(
                        label: 'Sell Price [1 Unit]',
                        hintText: 'e.g. 63500',
                        controller: sellPriceCtrl,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDialogStatusToggle(
                  value: status,
                  onChanged: (val) => setDlgState(() => status = val),
                ),
              ],
            ),
            saveLabel: product == null ? 'Register Product' : 'Save Changes',
            onSave: () {
              final name = nameCtrl.text.trim();
              final quantity = int.tryParse(quantityCtrl.text.trim()) ?? 0;
              final buyPrice = int.tryParse(buyPriceCtrl.text.trim()) ?? 0;
              final sellPrice = int.tryParse(sellPriceCtrl.text.trim()) ?? 0;

              if (name.isEmpty) {
                Get.snackbar('Warning', 'Product name cannot be empty');
                return;
              }
              if (selectedCategoryId == null || selectedBrandId == null) {
                Get.snackbar('Warning', 'Please select both category and brand');
                return;
              }

              if (product == null) {
                controller.addProduct(
                  Product(
                    name: name,
                    categoryId: selectedCategoryId!,
                    brandId: selectedBrandId!,
                    quality: selectedQuality,
                    quantity: quantity,
                    buyPrice: buyPrice,
                    sellPrice: sellPrice,
                    status: status,
                  ),
                );
              } else {
                product.name = name;
                product.categoryId = selectedCategoryId!;
                product.brandId = selectedBrandId!;
                product.quality = selectedQuality;
                product.quantity = quantity;
                product.buyPrice = buyPrice;
                product.sellPrice = sellPrice;
                product.status = status;
                controller.updateProduct(product);
              }
            },
          );
        },
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildDialogDropdown<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(AppColors.TEXTPRIMARY),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SaaSDropdown.build<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          backgroundColor: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          padding: const EdgeInsets.symmetric(horizontal: 14),
        ),
      ],
    );
  }

  Widget _buildDialogTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(AppColors.TEXTPRIMARY),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Color(AppColors.TEXTPRIMARY),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(AppColors.TEXTSECONDARY),
                fontSize: 13,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDialogStatusToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(
            value ? Icons.check_circle_rounded : Icons.pause_circle_rounded,
            color: value ? const Color(0xFF10B981) : const Color(0xFFEF4444),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value ? 'Active Product' : 'Inactive Product',
                  style: const TextStyle(
                    color: Color(AppColors.TEXTPRIMARY),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  value
                      ? 'Product is visible and available for stock.'
                      : 'Product is disabled.',
                  style: const TextStyle(
                    color: Color(AppColors.TEXTSECONDARY),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(AppColors.PRIMARY),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDialogCard({
    required String title,
    required String subtitle,
    required dynamic icon,
    required Widget content,
    required String saveLabel,
    required VoidCallback onSave,
  }) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 600,
        decoration: BoxDecoration(
          color: const Color(AppColors.WHITE),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: HugeIcon(
                        icon: icon,
                        color: const Color(AppColors.PRIMARY),
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Color(AppColors.TEXTPRIMARY),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Color(AppColors.TEXTSECONDARY),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(AppColors.TEXTSECONDARY),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            // Body
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: content,
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            // Footer Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(AppColors.TEXTSECONDARY),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(AppColors.PRIMARY),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const HugeIcon(
                          icon: AppIcons.CHECKICON,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          saveLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
