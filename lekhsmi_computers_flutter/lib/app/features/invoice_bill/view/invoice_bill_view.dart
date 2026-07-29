import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../controller/invoice_bill_controller.dart';

class InvoiceBillView extends StatelessWidget {
  const InvoiceBillView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceBillController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          _buildTitleSection(controller),
          Expanded(
            child: Row(
              children: [
                // Left Half: Interactive Editable Form
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(right: BorderSide(color: Color(0xFFE2E8F0))),
                    ),
                    child: _buildFormSection(context, controller),
                  ),
                ),

                // Right Half: Live Document Preview (Exact A4 Replica)
                Expanded(
                  flex: 1,
                  child: Container(
                    color: const Color(0xFFF1F5F9), // Subtle workspace background
                    child: _buildPreviewSection(context, controller),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(InvoiceBillController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(AppColors.WHITE),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Invoice / Bill Creator & POS',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(AppColors.TEXTPRIMARY),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(AppColors.PRIMARY).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Live Inventory Synced',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(AppColors.PRIMARY),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // LEFT SIDE: INTERACTIVE INVOICE FORM
  // ==========================================

  Widget _buildFormSection(BuildContext context, InvoiceBillController controller) {
    return Column(
      children: [
        // Top Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice Configuration',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: const Color(AppColors.TEXTPRIMARY),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Select items from live inventory; stock is deducted automatically',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(AppColors.TEXTSECONDARY),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () => controller.clearForm(),
                icon: const Icon(Icons.refresh_rounded, size: 15, color: Color(AppColors.TEXTSECONDARY)),
                label: Text('Reset Form', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12)),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(AppColors.TEXTSECONDARY),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Form Body
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCustomerFormCard(context, controller),
                const SizedBox(height: 20),
                _buildItemsFormCard(context, controller),
                const SizedBox(height: 20),
                _buildGstFormCard(context, controller),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerFormCard(BuildContext context, InvoiceBillController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer & Billing Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: controller.nameController,
                  label: 'Customer Name',
                  hint: 'Enter customer name',
                  icon: Icons.person_outline_rounded,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildTextField(
                  controller: controller.phoneController,
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  icon: Icons.phone_outlined,
                  isNumber: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: controller.emailController,
                  label: 'Email Address (Optional)',
                  hint: 'customer@email.com',
                  icon: Icons.email_outlined,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildTextField(
                  controller: controller.addressController,
                  label: 'Address',
                  hint: 'Street, City, PIN',
                  icon: Icons.location_on_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Obx(() => _buildDatePickerBox(
                      context: context,
                      label: 'Invoice Date',
                      date: controller.currentDate.value,
                      onTap: () => controller.pickDate(context, true),
                    )),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Obx(() => _buildDatePickerBox(
                      context: context,
                      label: 'Due Date',
                      date: controller.validUptoDate.value,
                      onTap: () => controller.pickDate(context, false),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsFormCard(BuildContext context, InvoiceBillController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Products / Stock Items (A4 Sheet Limit)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
              ),
              Obx(() {
                final count = controller.items.length;
                final isMax = count >= 10;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isMax ? const Color(0xFFFEF2F2) : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isMax ? const Color(0xFFEF4444) : const Color(0xFF3B82F6),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '$count / 10 Max',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isMax ? const Color(0xFFEF4444) : const Color(0xFF2563EB),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 12),

          // Inventory Product Selection Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 5,
                child: _buildProductSelector(context, controller),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 110,
                child: Obx(() {
                  final product = controller.selectedProduct.value;
                  final isOutOfStock = product != null && product.quantity <= 0;
                  final maxQty = product?.quantity;
                  String label = 'Qty';
                  if (product != null) {
                    if (isOutOfStock) {
                      label = 'Qty (0 Stock)';
                    } else {
                      label = 'Qty (Max: $maxQty)';
                    }
                  }
                  return _buildTextField(
                    controller: controller.itemQuantityController,
                    label: label,
                    hint: isOutOfStock ? '0' : '1',
                    icon: Icons.numbers_rounded,
                    isNumber: true,
                    enabled: !isOutOfStock,
                    onChanged: (val) => controller.validateQuantityInput(val),
                  );
                }),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 130,
                child: _buildTextField(
                  controller: controller.itemPriceController,
                  label: 'Price (₹)',
                  hint: 'Price',
                  icon: Icons.currency_rupee_rounded,
                  isNumber: true,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  onPressed: () => controller.addItem(),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add Item', style: TextStyle(fontWeight: FontWeight.w700)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(AppColors.PRIMARY),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Table of added items
          Obx(() {
            final items = controller.items;
            if (items.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Center(
                  child: Text(
                    'No items added yet. Select a product from inventory above.',
                    style: TextStyle(fontSize: 13, color: Color(AppColors.TEXTSECONDARY)),
                  ),
                ),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text('NO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTSECONDARY))),
                        ),
                        Expanded(
                          child: Text('PRODUCT / SERVICE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTSECONDARY))),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text('QTY x PRICE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTSECONDARY))),
                        ),
                        SizedBox(
                          width: 100,
                          child: Text('AMOUNT', textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTSECONDARY))),
                        ),
                        SizedBox(width: 36),
                      ],
                    ),
                  ),

                  // Items List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (context, idx) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    itemBuilder: (context, idx) {
                      final item = items[idx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                '${idx + 1}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.productName,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                '${item.quantity} x ₹${item.price.toStringAsFixed(0)}',
                                style: const TextStyle(fontSize: 13, color: Color(AppColors.TEXTSECONDARY)),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                '₹${item.amount.toStringAsFixed(2)}',
                                textAlign: TextAlign.right,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                              ),
                            ),
                            SizedBox(
                              width: 36,
                              child: IconButton(
                                onPressed: () => controller.removeItem(item.id),
                                icon: const Icon(Icons.close_rounded, size: 18, color: Color(0xFFEF4444)),
                                tooltip: 'Remove item',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProductSelector(BuildContext context, InvoiceBillController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Select Product (From Inventory)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () => controller.refreshProducts(),
              child: const Text(
                'Reload Stock',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(AppColors.PRIMARY)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Obx(() {
          final products = controller.products;
          final selected = controller.selectedProduct.value;
          final isLoading = controller.isLoadingProducts.value;

          final uniqueProducts = <int, Product>{};
          for (final p in products) {
            if (p.id != null) {
              uniqueProducts[p.id!] = p;
            } else {
              uniqueProducts[p.hashCode] = p;
            }
          }
          final displayProducts = uniqueProducts.values.toList();

          Product? validSelected;
          if (selected != null) {
            validSelected = displayProducts
                .where((p) => p.id == selected.id || identical(p, selected))
                .firstOrNull;
          }

          return Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: isLoading
                ? const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)))
                : DropdownButtonHideUnderline(
                    child: DropdownButton<Product>(
                      value: validSelected,
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      elevation: 12,
                      hint: Text(
                        'Choose product from stock...',
                        style: GoogleFonts.inter(fontSize: 13, color: const Color(AppColors.TEXTSECONDARY)),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(AppColors.TEXTSECONDARY)),
                      onChanged: (Product? newProduct) {
                        controller.selectProduct(newProduct);
                      },
                      items: displayProducts.map((Product p) {
                        final isOutOfStock = p.quantity <= 0;
                        return DropdownMenuItem<Product>(
                          value: p,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  p.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isOutOfStock ? const Color(0xFFEF4444) : const Color(AppColors.TEXTPRIMARY),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: isOutOfStock ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: isOutOfStock ? const Color(0xFFFCA5A5) : const Color(0xFF86EFAC),
                                  ),
                                ),
                                child: Text(
                                  isOutOfStock ? '0 Stock' : 'Stock: ${p.quantity}',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: isOutOfStock ? const Color(0xFFEF4444) : const Color(0xFF16A34A),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '₹${p.sellPrice}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(AppColors.TEXTPRIMARY),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          );
        }),
      ],
    );
  }

  Widget _buildGstFormCard(BuildContext context, InvoiceBillController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GST / Taxes',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Toggle to apply GST percentage to the invoice bill total',
                    style: TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY)),
                  ),
                ],
              ),
              Obx(() => Switch(
                    value: controller.isGstEnabled.value,
                    onChanged: (val) => controller.toggleGst(val),
                    activeThumbColor: const Color(AppColors.PRIMARY),
                  )),
            ],
          ),

          // Conditional GST Percentage Input
          Obx(() {
            if (!controller.isGstEnabled.value) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: _buildTextField(
                      controller: controller.gstInputController,
                      label: 'GST Percentage (%)',
                      hint: '18',
                      icon: Icons.percent_rounded,
                      isNumber: true,
                      onChanged: (val) => controller.updateGstPercentage(val),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'This percentage will be calculated on the subtotal and added to the Total Amount.',
                      style: TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY)),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ==========================================
  // RIGHT SIDE: LIVE DOCUMENT PREVIEW
  // ==========================================

  Widget _buildPreviewSection(BuildContext context, InvoiceBillController controller) {
    return Column(
      children: [
        // Action Bar for Preview
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.receipt_long_rounded, size: 20, color: Color(AppColors.PRIMARY)),
                  const SizedBox(width: 8),
                  Text(
                    'Live Invoice / Bill Preview (A4)',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(AppColors.TEXTPRIMARY)),
                  ),
                  const SizedBox(width: 12),
                  Obx(() {
                    final count = controller.items.length;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$count / 10 Items',
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY)),
                      ),
                    );
                  }),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => controller.printInvoiceBillPdf(),
                icon: const Icon(Icons.print_rounded, size: 18),
                label: Text('Print Invoice Bill (B&W)', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E293B), // Premium dark for B&W print button
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),

        // Scrollable Document Preview
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Container(
                width: 760, // Standard document aspect width
                constraints: const BoxConstraints(minHeight: 1075), // Exact A4 height proportion (210mm x 297mm)
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Invoice Header (Logo & Contact Info)
                    _buildDocumentHeader(),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(height: 1, thickness: 1, color: Color(0xFFCBD5E1)),
                    ),

                    // 2. Customer Details Section
                    _buildDocumentCustomerDetails(controller),

                    const SizedBox(height: 28),

                    // 3. Items Table
                    _buildDocumentItemsTable(controller),

                    const SizedBox(height: 16),

                    // 4. Totals Block
                    _buildDocumentTotalsBlock(controller),

                    const SizedBox(height: 64),

                    // 5. Terms & Conditions and Authorized Signature
                    _buildDocumentFooter(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentHeader() {
    final settings = Get.find<SettingsController>();
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                settings.storeName.value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(AppColors.TEXTPRIMARY),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Sales   |   Service   |   Repair   |   Support',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(AppColors.TEXTSECONDARY),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'INVOICE / BILL',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(AppColors.TEXTPRIMARY),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phone: ${settings.storePhone.value}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(AppColors.TEXTPRIMARY),
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text('Email: ${settings.storeEmail.value}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(AppColors.TEXTPRIMARY),
                      fontWeight: FontWeight.w500)),
              if (settings.storeWebsite.value.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text('Web: ${settings.storeWebsite.value}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color(AppColors.TEXTPRIMARY),
                        fontWeight: FontWeight.w500)),
              ],
              const SizedBox(height: 4),
              Text('Address: ${settings.storeAddress.value}',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(AppColors.TEXTPRIMARY),
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildDocumentCustomerDetails(InvoiceBillController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY)),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                final name = controller.customerName.value.trim();
                final phone = controller.phone.value.trim();
                final address = controller.address.value.trim();
                final email = controller.email.value.trim();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty ? 'Valued Customer' : name,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                    ),
                    if (phone.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('Phone: $phone', style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
                    ],
                    if (address.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('Address: $address', style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
                    ],
                    if (email.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('Email: $email', style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
                    ],
                  ],
                );
              }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Obx(() => Text(
                      'Date :   ${_formatDate(controller.currentDate.value)}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                    )),
                const SizedBox(height: 6),
                Obx(() => Text(
                      'Due Date :   ${_formatDate(controller.validUptoDate.value)}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDocumentItemsTable(InvoiceBillController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(AppColors.TEXTPRIMARY), width: 1.5),
              bottom: BorderSide(color: Color(AppColors.TEXTPRIMARY), width: 1.5),
            ),
          ),
          child: const Row(
            children: [
              SizedBox(
                width: 40,
                child: Text('NO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY))),
              ),
              Expanded(
                child: Text('Product / Service Description', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY))),
              ),
              SizedBox(
                width: 120,
                child: Text('Amount', textAlign: TextAlign.right, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY))),
              ),
            ],
          ),
        ),

        // Items List
        Obx(() {
          final items = controller.items;
          if (items.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'No items added',
                  style: TextStyle(fontSize: 13, color: Color(AppColors.TEXTSECONDARY)),
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, idx) {
              final item = items[idx];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text('${idx + 1}', style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTPRIMARY))),
                    ),
                    Expanded(
                      child: Text(
                        item.quantity > 1
                            ? '${item.productName} (${item.quantity} x ₹${item.price.toStringAsFixed(0)})'
                            : item.productName,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        _formatCurrency(item.amount),
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildDocumentTotalsBlock(InvoiceBillController controller) {
    return Obx(() {
      final sub = controller.subTotal;
      final isGst = controller.isGstEnabled.value;
      final gstPct = controller.gstPercentage.value;
      final gstAmt = controller.gstAmount;
      final total = controller.totalAmount;

      return Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          width: 260,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isGst ? FontWeight.w500 : FontWeight.w800,
                        color: const Color(AppColors.TEXTPRIMARY),
                      )),
                  Text(_formatCurrency(sub),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isGst ? FontWeight.w500 : FontWeight.w800,
                        color: const Color(AppColors.TEXTPRIMARY),
                      )),
                ],
              ),
              if (isGst) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('GST (${gstPct.toStringAsFixed(gstPct == gstPct.toInt() ? 0 : 1)}%)',
                        style: const TextStyle(fontSize: 13, color: Color(AppColors.TEXTPRIMARY))),
                    Text(_formatCurrency(gstAmt), style: const TextStyle(fontSize: 13, color: Color(AppColors.TEXTPRIMARY))),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(height: 1, thickness: 1, color: Color(AppColors.TEXTPRIMARY)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY))),
                    Text(_formatCurrency(total), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY))),
                  ],
                ),
              ] else ...[
                const SizedBox(height: 8),
                const Divider(height: 1, thickness: 1, color: Color(AppColors.TEXTPRIMARY)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY))),
                    Text(_formatCurrency(total), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY))),
                  ],
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDocumentFooter() {
    return const Column(
      children: [
        Divider(height: 1, thickness: 1, color: Color(0xFFCBD5E1)),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Terms & Conditions', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY))),
                  SizedBox(height: 6),
                  Text('1. Goods once sold cannot be taken back.', style: TextStyle(fontSize: 10, color: Color(AppColors.TEXTSECONDARY))),
                  SizedBox(height: 2),
                  Text('2. No Warranty for Physical/Tampering (Incl. stickers).', style: TextStyle(fontSize: 10, color: Color(AppColors.TEXTSECONDARY))),
                  SizedBox(height: 2),
                  Text('3. Bill Copy Necessary for Claiming Warranty.', style: TextStyle(fontSize: 10, color: Color(AppColors.TEXTSECONDARY))),
                  SizedBox(height: 2),
                  Text('4. No Warranty for Software Installation.', style: TextStyle(fontSize: 10, color: Color(AppColors.TEXTSECONDARY))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 35),
                Text('Authorized Signature', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY))),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================
  // COMMON HELPERS & WIDGETS
  // ==========================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isNumber = false,
    bool enabled = true,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: enabled,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 13,
            color: enabled
                ? const Color(AppColors.TEXTPRIMARY)
                : const Color(0xFF94A3B8),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(AppColors.TEXTSECONDARY), fontSize: 13),
            prefixIcon: Icon(icon, size: 18, color: const Color(AppColors.TEXTSECONDARY)),
            prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            filled: true,
            fillColor: enabled ? Colors.white : const Color(0xFFF1F5F9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(AppColors.PRIMARY), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerBox({
    required BuildContext context,
    required String label,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 16, color: Color(AppColors.TEXTSECONDARY)),
                const SizedBox(width: 10),
                Text(
                  _formatDate(date),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  String _formatCurrency(double amount) {
    final absAmount = amount.abs();
    final parts = absAmount.toStringAsFixed(2).split('.');
    String intPart = parts[0];
    final decPart = parts[1];

    if (intPart.length > 3) {
      final lastThree = intPart.substring(intPart.length - 3);
      final remaining = intPart.substring(0, intPart.length - 3);
      final buffer = StringBuffer();
      for (int i = 0; i < remaining.length; i++) {
        if (i > 0 && (remaining.length - i) % 2 == 0) {
          buffer.write(',');
        }
        buffer.write(remaining[i]);
      }
      intPart = '${buffer.toString()},$lastThree';
    }

    final formatted = '₹$intPart.$decPart';
    if (amount < 0) return '-$formatted';
    return formatted;
  }
}
