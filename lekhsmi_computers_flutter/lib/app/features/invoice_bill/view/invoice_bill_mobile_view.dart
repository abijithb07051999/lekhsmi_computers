import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_document_preview_page.dart';
import 'package:lekhsmi_computers_flutter/app/features/invoice_bill/controller/invoice_bill_controller.dart';
import 'invoice_bill_view.dart';

class InvoiceBillMobileView extends StatelessWidget {
  const InvoiceBillMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceBillController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildTitleSection(controller),
          Expanded(
            child: _buildFormSection(context, controller),
          ),
        ],
      ),
      bottomNavigationBar: _buildMobilePreviewButtonBar(context, controller),
    );
  }

  Widget _buildTitleSection(InvoiceBillController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Color(AppColors.WHITE),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Invoice / Bill Creator',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(AppColors.TEXTPRIMARY),
            ),
          ),
          TextButton.icon(
            onPressed: () => controller.clearForm(),
            icon: const Icon(Icons.refresh_rounded, size: 15, color: Color(AppColors.TEXTSECONDARY)),
            label: Text('Reset', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12)),
            style: TextButton.styleFrom(
              foregroundColor: const Color(AppColors.TEXTSECONDARY),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(BuildContext context, InvoiceBillController controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        14,
        14,
        14,
        14 + MediaQuery.of(context).viewInsets.bottom,
      ),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerFormCard(context, controller),
          const SizedBox(height: 16),
          _buildItemsFormCard(context, controller),
          const SizedBox(height: 16),
          _buildGstFormCard(context, controller),
          const SizedBox(height: 16),
          _buildSummaryCard(controller),
        ],
      ),
    );
  }

  Widget _buildCustomerFormCard(BuildContext context, InvoiceBillController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          InvoiceBillDialogs.buildTextField(
            controller: controller.nameController,
            label: 'Customer Name',
            hint: 'Enter customer name',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 12),
          InvoiceBillDialogs.buildTextField(
            controller: controller.phoneController,
            label: 'Phone Number',
            hint: 'Enter phone number',
            icon: Icons.phone_outlined,
            isPhone: true,
          ),
          const SizedBox(height: 12),
          InvoiceBillDialogs.buildTextField(
            controller: controller.addressController,
            label: 'Customer Address',
            hint: 'Enter address',
            icon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 12),
          Obx(() {
            return InvoiceBillDialogs.buildDatePickerBox(
              context: context,
              label: 'Billing Date',
              date: controller.currentDate.value,
              onTap: () async {
                final selected = await showDatePicker(
                  context: context,
                  initialDate: controller.currentDate.value,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2035),
                );
                if (selected != null) {
                  controller.currentDate.value = selected;
                }
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildItemsFormCard(BuildContext context, InvoiceBillController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                  'Products / Stock Items',
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
          _buildProductSelector(context, controller),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Obx(() {
                  final isCustom = controller.isCustomItem.value;
                  final prod = controller.selectedProduct.value;
                  final maxQty = prod?.quantity ?? 0;
                  return InvoiceBillDialogs.buildTextField(
                    controller: controller.itemQuantityController,
                    label: (isCustom || maxQty == 0) ? 'Qty' : 'Qty (Max: $maxQty)',
                    hint: '1',
                    icon: Icons.numbers_rounded,
                    isNumber: true,
                    enabled: isCustom || prod != null,
                    onChanged: (val) => controller.validateQuantityInput(val),
                  );
                }),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Obx(() {
                  final isCustom = controller.isCustomItem.value;
                  final prod = controller.selectedProduct.value;
                  return InvoiceBillDialogs.buildTextField(
                    controller: controller.itemPriceController,
                    label: 'Unit Price (₹)',
                    hint: '0',
                    icon: Icons.currency_rupee_rounded,
                    isNumber: true,
                    enabled: isCustom || prod != null,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () => controller.addItem(),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Add Item to Invoice', style: TextStyle(fontWeight: FontWeight.w700)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(AppColors.PRIMARY),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Added Items Mobile List
          Obx(() {
            final items = controller.items;
            if (items.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(AppColors.PRIMARY)),
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
                                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(AppColors.TEXTPRIMARY)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${items[idx].quantity} × ${InvoiceBillDialogs.formatCurrency(items[idx].price)} = ${InvoiceBillDialogs.formatCurrency(items[idx].amount)}',
                                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY)),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.removeItem(items[idx].id),
                            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 18),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ],
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
            return InvoiceBillDialogs.buildTextField(
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
                                  isOutOfStock ? 'Out of Stock' : 'Stock: ${p.quantity}',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: isOutOfStock ? const Color(0xFFEF4444) : const Color(0xFF16A34A),
                                  ),
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
      padding: const EdgeInsets.all(16),
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enable GST Calculation',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(AppColors.TEXTPRIMARY),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Adds GST percentage to the bill',
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
                  activeThumbColor: const Color(AppColors.PRIMARY),
                  onChanged: (val) {
                    controller.isGstEnabled.value = val;
                  },
                );
              }),
            ],
          ),
          Obx(() {
            if (!controller.isGstEnabled.value) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                const SizedBox(height: 14),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 14),
                InvoiceBillDialogs.buildTextField(
                  controller: controller.gstInputController,
                  label: 'GST Percentage (%)',
                  hint: '18',
                  icon: Icons.percent_rounded,
                  isNumber: true,
                  onChanged: (val) => controller.updateGstPercentage(val),
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
                          'An extra ${controller.gstPercentage.value.toStringAsFixed(0)}% GST (${InvoiceBillDialogs.formatCurrency(controller.gstAmount)}) will be added.',
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
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(InvoiceBillController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Obx(() {
        final subtotal = controller.subTotal;
        final gst = controller.gstAmount;
        final total = controller.totalAmount;
        final isGst = controller.isGstEnabled.value;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: TextStyle(fontSize: 13, color: Color(AppColors.TEXTSECONDARY))),
                Text(InvoiceBillDialogs.formatCurrency(subtotal), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY))),
              ],
            ),
            if (isGst) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('GST (${controller.gstPercentage.value.toStringAsFixed(0)}%)', style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
                  Text(InvoiceBillDialogs.formatCurrency(gst), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTPRIMARY))),
                ],
              ),
            ],
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1, color: Color(0xFFBFDBFE)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Payable', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(AppColors.PRIMARY))),
                Text(InvoiceBillDialogs.formatCurrency(total), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(AppColors.PRIMARY))),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMobilePreviewButtonBar(BuildContext context, InvoiceBillController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton.icon(
          onPressed: () {
            if (controller.validateBeforePrint()) {
              SaaSDocumentPreviewPage.show(
                context,
                documentTitle: 'INVOICE & BILL',
                isQuotation: false,
                onLayout: controller.generatePdfBytes,
                onSave: controller.saveInvoiceBillPdf,
                onShare: controller.shareInvoiceBillPdf,
              );
            }
          },
          icon: const Icon(Icons.visibility_rounded, size: 20),
          label: Text(
            'Preview Invoice & Bill',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(AppColors.PRIMARY),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
