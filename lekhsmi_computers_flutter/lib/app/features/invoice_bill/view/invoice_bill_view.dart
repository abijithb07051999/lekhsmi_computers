import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../controller/invoice_bill_controller.dart';
import 'package:lekhsmi_computers_flutter/core/utils/responsive_utils.dart';
import 'invoice_bill_mobile_view.dart';

class InvoiceBillView extends StatelessWidget {
  const InvoiceBillView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceBillController());
    final bool isPhone = ResponsiveUtils.isPhone(context);

    if (isPhone) {
      return const InvoiceBillMobileView();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(AppColors.WHITE),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Invoice / Bill Creator & POS',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(AppColors.TEXTPRIMARY),
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
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
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.isPhone(context) ? 14 : 24,
            vertical: ResponsiveUtils.isPhone(context) ? 12 : 16,
          ),
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
            padding: EdgeInsets.fromLTRB(
              ResponsiveUtils.isPhone(context) ? 14 : 24,
              ResponsiveUtils.isPhone(context) ? 14 : 24,
              ResponsiveUtils.isPhone(context) ? 14 : 24,
              (ResponsiveUtils.isPhone(context) ? 14 : 24) + MediaQuery.of(context).viewInsets.bottom,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
    final isPhone = ResponsiveUtils.isPhone(context);
    return Container(
      padding: EdgeInsets.all(isPhone ? 16 : 20),
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
          if (isPhone) ...[
            _buildTextField(
              controller: controller.nameController,
              label: 'Customer Name',
              hint: 'Enter customer name',
              icon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: controller.phoneController,
              label: 'Phone Number',
              hint: 'Enter phone number',
              icon: Icons.phone_outlined,
              isPhone: true,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: controller.emailController,
              label: 'Email Address (Optional)',
              hint: 'customer@email.com',
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: controller.addressController,
              label: 'Address',
              hint: 'Street, City, PIN',
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),
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
                const SizedBox(width: 12),
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
          ] else ...[
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
                    isPhone: true,
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
        ],
      ),
    );
  }


  Widget _buildItemsFormCard(BuildContext context, InvoiceBillController controller) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.isPhone(context) ? 16 : 20),
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
              const Expanded(
                child: Text(
                  'Products / Stock Items (A4 Sheet Limit)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Obx(() {
                final count = controller.items.length;
                final isMax = count >= 13;
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
                    '$count / 13 Max',
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

          // Inventory Product Selection
          if (ResponsiveUtils.isPhone(context)) ...[
            _buildProductSelector(context, controller),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Obx(() {
                    final isCustom = controller.isCustomItem.value;
                    final product = controller.selectedProduct.value;
                    final isOutOfStock = !isCustom && product != null && product.quantity <= 0;
                    final maxQty = product?.quantity;
                    
                    String label = 'Qty';
                    if (!isCustom && product != null) {
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
                Expanded(
                  flex: 1,
                  child: _buildTextField(
                    controller: controller.itemPriceController,
                    label: 'Price (₹)',
                    hint: 'Price',
                    icon: Icons.currency_rupee_rounded,
                    isNumber: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: () => controller.addItem(),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Add Item', style: TextStyle(fontWeight: FontWeight.w700)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(AppColors.PRIMARY),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ] else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildProductSelector(context, controller),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    final isCustom = controller.isCustomItem.value;
                    final product = controller.selectedProduct.value;
                    final isOutOfStock = !isCustom && product != null && product.quantity <= 0;
                    final maxQty = product?.quantity;
                    
                    String label = 'Qty';
                    if (!isCustom && product != null) {
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
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    controller: controller.itemPriceController,
                    label: 'Price (₹)',
                    hint: 'Price',
                    icon: Icons.currency_rupee_rounded,
                    isNumber: true,
                  ),
                ),
                const SizedBox(width: 8),
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
          ],

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
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (ResponsiveUtils.isPhone(context)) {
              // Mobile: Card view for items
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    for (int idx = 0; idx < items.length; idx++) ...[
                      if (idx > 0) const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  '${idx + 1}',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(AppColors.PRIMARY)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[idx].productName,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                                  ),
                                  Text(
                                    '${items[idx].quantity} × ₹${items[idx].price.toStringAsFixed(0)}',
                                    style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY)),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '₹${items[idx].amount.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF10B981)),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              onPressed: () => controller.removeItem(items[idx].id),
                              icon: const Icon(Icons.close_rounded, size: 18, color: Color(0xFFEF4444)),
                              tooltip: 'Remove item',
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
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
                  Column(
                    children: [
                      for (int idx = 0; idx < items.length; idx++) ...[
                        if (idx > 0) const Divider(height: 1, color: Color(0xFFF1F5F9)),
                        Padding(
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
                                  items[idx].productName,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  '${items[idx].quantity} x ₹${items[idx].price.toStringAsFixed(0)}',
                                  style: const TextStyle(fontSize: 13, color: Color(AppColors.TEXTSECONDARY)),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  '₹${items[idx].amount.toStringAsFixed(2)}',
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                                ),
                              ),
                              SizedBox(
                                width: 36,
                                child: IconButton(
                                  onPressed: () => controller.removeItem(items[idx].id),
                                  icon: const Icon(Icons.close_rounded, size: 18, color: Color(0xFFEF4444)),
                                  tooltip: 'Remove item',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
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
            Expanded(
              child: Obx(() {
                return Text(
                  controller.isCustomItem.value ? 'Custom Item Details' : 'Select Product from Stock',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY)),
                );
              }),
            ),
            const SizedBox(width: 8),
            Obx(() {
              return SegmentedButton<bool>(
                segments: const [
                  ButtonSegment<bool>(
                    value: false,
                    label: Text('Stock', style: TextStyle(fontSize: 11)),
                  ),
                  ButtonSegment<bool>(
                    value: true,
                    label: Text('Custom', style: TextStyle(fontSize: 11)),
                  ),
                ],
                selected: {controller.isCustomItem.value},
                onSelectionChanged: (Set<bool> newSelection) {
                  controller.isCustomItem.value = newSelection.first;
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              );
            }),
            Obx(() {
              if (controller.isCustomItem.value) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Tooltip(
                  message: 'Reload Stock',
                  child: InkWell(
                    onTap: () => controller.refreshProducts(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Icon(Icons.refresh_rounded, size: 16, color: Color(AppColors.PRIMARY)),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 6),
        Obx(() {
          if (controller.isCustomItem.value) {
            return _buildTextField(
              controller: controller.customItemNameController,
              label: 'Item Name / Description',
              hint: 'E.g., Custom Repair Service',
              icon: Icons.edit_note_rounded,
            );
          }

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
                      selectedItemBuilder: (BuildContext context) {
                        return displayProducts.map<Widget>((Product p) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              p.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(AppColors.TEXTPRIMARY),
                              ),
                            ),
                          );
                        }).toList();
                      },
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Enable GST Calculation',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(AppColors.TEXTPRIMARY),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'When enabled, adds GST percentage to the bill. When disabled, GST is completely hidden.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(AppColors.TEXTSECONDARY),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Switch(
                  value: controller.isGstEnabled.value,
                  onChanged: (val) => controller.toggleGst(val),
                  activeThumbColor: const Color(AppColors.PRIMARY),
                );
              }),
            ],
          ),

          Obx(() {
            if (!controller.isGstEnabled.value) {
              return const SizedBox.shrink();
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: _buildTextField(
                        controller: controller.gstInputController,
                        label: 'GST Percentage (%)',
                        hint: 'e.g. 18',
                        icon: Icons.percent_rounded,
                        isNumber: true,
                        onChanged: (val) => controller.updateGstPercentage(val),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(AppColors.PRIMARY).withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline_rounded, size: 18, color: Color(AppColors.PRIMARY)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'An extra ${controller.gstPercentage.value.toStringAsFixed(0)}% GST (${_formatCurrency(controller.gstAmount)}) will be added to the subtotal.',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(AppColors.PRIMARY),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.receipt_long_rounded, color: Color(AppColors.PRIMARY), size: 18),
                    const SizedBox(width: 6),
                    const Flexible(
                      child: Text(
                        'Invoice Preview (A4)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    final count = controller.items.length;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '$count / 13 Items',
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY)),
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  if (!ResponsiveUtils.isPhone(context)) ...[
                    ElevatedButton.icon(
                      onPressed: () => controller.savePdfDesktop(),
                      icon: const Icon(Icons.download_rounded, size: 16),
                      label: Text(
                        'Save as PDF',
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF1F5F9),
                        foregroundColor: const Color(AppColors.TEXTPRIMARY),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => controller.printInvoiceBillPdf(),
                      icon: const Icon(Icons.print_rounded, size: 16),
                      label: Text(
                        'Print Invoice',
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ],
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
                height: 1075, // Exact A4 height proportion (210mm x 297mm)
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 60),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                      ],
                    ),

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
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  settings.storeName.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Sales   |   Service   |   Repair   |   Support',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'INVOICE / BILL',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Phone: ${settings.storePhone.value}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('Email: ${settings.storeEmail.value}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                if (settings.storeWebsite.value.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text('Web: ${settings.storeWebsite.value}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ],
                const SizedBox(height: 4),
                Text('Address: ${settings.storeAddress.value}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
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
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
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
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    if (phone.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('Phone: $phone', style: const TextStyle(fontSize: 11, color: Color(0xFF1E293B))),
                    ],
                    if (address.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('Address: $address', style: const TextStyle(fontSize: 11, color: Color(0xFF1E293B))),
                    ],
                    if (email.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text('Email: $email', style: const TextStyle(fontSize: 11, color: Color(0xFF1E293B))),
                    ],
                  ],
                );
              }),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() => Text(
                        'Date :   ${_formatDate(controller.currentDate.value)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                  const SizedBox(height: 6),
                  Obx(() => Text(
                        'Due Date :   ${_formatDate(controller.validUptoDate.value)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                ],
              ),
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
              top: BorderSide(color: Colors.black, width: 1.5),
              bottom: BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
          child: const Row(
            children: [
              SizedBox(
                width: 40,
                child: Text('NO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              Expanded(
                child: Text('Product / Service Description', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
              SizedBox(
                width: 100,
                child: Text('Amount', textAlign: TextAlign.right, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
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
                  style: TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY)),
                ),
              ),
            );
          }

          return Column(
            children: [
              for (int idx = 0; idx < items.length; idx++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Text('${idx + 1}', style: const TextStyle(fontSize: 11, color: Colors.black)),
                      ),
                      Expanded(
                        child: Text(
                          items[idx].quantity > 1
                              ? '${items[idx].productName} (${items[idx].quantity} x ${_formatCurrency(items[idx].price)})'
                              : items[idx].productName,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          _formatCurrency(items[idx].amount),
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
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
          width: 290,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isGst ? FontWeight.normal : FontWeight.bold,
                        color: Colors.black,
                      )),
                  Text(_formatCurrency(sub),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isGst ? FontWeight.normal : FontWeight.bold,
                        color: Colors.black,
                      )),
                ],
              ),
              if (isGst) ...[
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('GST (${gstPct.toStringAsFixed(gstPct == gstPct.toInt() ? 0 : 1)}%)',
                        style: const TextStyle(fontSize: 11, color: Colors.black)),
                    Text(_formatCurrency(gstAmt),
                        style: const TextStyle(fontSize: 11, color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(height: 1, thickness: 1, color: Colors.black),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
                    Text(_formatCurrency(total), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ] else ...[
                const SizedBox(height: 6),
                const Divider(height: 1, thickness: 1, color: Colors.black),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
                    Text(_formatCurrency(total), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
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
        Divider(height: 1, thickness: 1, color: Color(0xFF64748B)),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Terms & Conditions', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 4),
                  Text('1. Goods once sold cannot be taken back.', style: TextStyle(fontSize: 8.5, color: Color(0xFF1E293B))),
                  SizedBox(height: 2),
                  Text('2. No Warranty for Physical/Tampering (Incl. stickers).', style: TextStyle(fontSize: 8.5, color: Color(0xFF1E293B))),
                  SizedBox(height: 2),
                  Text('3. Bill Copy Necessary for Claiming Warranty.', style: TextStyle(fontSize: 8.5, color: Color(0xFF1E293B))),
                  SizedBox(height: 2),
                  Text('4. No Warranty for Software Installation.', style: TextStyle(fontSize: 8.5, color: Color(0xFF1E293B))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 30),
                Text('Authorized Signature', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.black)),
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
    bool isPhone = false,
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
          keyboardType: isPhone ? TextInputType.phone : (isNumber ? TextInputType.number : TextInputType.text),
          onChanged: onChanged,
          scrollPadding: const EdgeInsets.only(bottom: 220),
          style: TextStyle(
            fontSize: 13,
            color: enabled
                ? const Color(AppColors.TEXTPRIMARY)
                : const Color(0xFF94A3B8),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(AppColors.HINTTEXT),
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
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

    final formatted = 'Rs. $intPart.$decPart';
    if (amount < 0) return '-$formatted';
    return formatted;
  }
}

class InvoiceBillDialogs {
  static Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isNumber = false,
    bool isPhone = false,
    bool enabled = true,
    Function(String)? onChanged,
  }) => const InvoiceBillView()._buildTextField(
        controller: controller,
        label: label,
        hint: hint,
        icon: icon,
        isNumber: isNumber,
        isPhone: isPhone,
        enabled: enabled,
        onChanged: onChanged,
      );

  static Widget buildDatePickerBox({
    required BuildContext context,
    required String label,
    required DateTime date,
    required VoidCallback onTap,
  }) => const InvoiceBillView()._buildDatePickerBox(
        context: context,
        label: label,
        date: date,
        onTap: onTap,
      );

  static String formatDate(DateTime dt) => const InvoiceBillView()._formatDate(dt);
  static String formatCurrency(double amount) => const InvoiceBillView()._formatCurrency(amount);
}

