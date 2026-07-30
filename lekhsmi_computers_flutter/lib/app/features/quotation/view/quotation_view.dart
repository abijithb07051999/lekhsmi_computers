import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import '../controller/quotation_controller.dart';

class QuotationView extends StatelessWidget {
  const QuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuotationController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          _buildTitleSection(controller),
          Expanded(
            child: Row(
              children: [
                // Left Side: Interactive Form (50% width)
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
                // Right Side: Live Quotation Document Preview (50% width)
                Expanded(
                  flex: 1,
                  child: _buildPreviewSection(context, controller),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(QuotationController controller) {
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
                'Quotation / Estimate Builder',
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
                  'Live Preview Enabled',
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

  Widget _buildFormSection(BuildContext context, QuotationController controller) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Form Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                const Icon(Icons.description_outlined, color: Color(AppColors.PRIMARY), size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quotation Configuration',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: const Color(AppColors.TEXTPRIMARY),
                        ),
                      ),
                      Text(
                        'Fill customer details, items & tax settings',
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

          // Scrollable Form Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Customer Details Section
                  _buildSectionTitle('Customer Details', Icons.person_outline),
                  const SizedBox(height: 16),
                  _buildCustomerFormCard(context, controller),

                  const SizedBox(height: 28),

                  // 2. Items / Products Section
                  _buildSectionTitle('Products / Services', Icons.inventory_2_outlined),
                  const SizedBox(height: 16),
                  _buildItemsFormCard(context, controller),

                  const SizedBox(height: 28),

                  // 3. GST Settings Section
                  _buildSectionTitle('Tax & GST Settings', Icons.percent_outlined),
                  const SizedBox(height: 16),
                  _buildGstFormCard(context, controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(AppColors.PRIMARY)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Color(AppColors.TEXTPRIMARY),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerFormCard(BuildContext context, QuotationController controller) {
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
                child: _buildTextField(
                  controller: controller.customerNameController,
                  label: 'Customer Name',
                  hint: 'e.g. Anusha s',
                  icon: Icons.person_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: controller.phoneController,
                  label: 'Phone Number',
                  hint: 'e.g. +91 9876543210',
                  icon: Icons.phone_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: controller.emailController,
                  label: 'Email (Optional)',
                  hint: 'e.g. lekhsmicomputers@gmail.com',
                  icon: Icons.email_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Valid Upto Date',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(AppColors.TEXTSECONDARY),
                      ),
                    ),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () => controller.selectValidUptoDate(context),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFCBD5E1)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded, size: 16, color: Color(AppColors.PRIMARY)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Obx(() {
                                return Text(
                                  controller.formatDate(controller.validUptoDate.value),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(AppColors.TEXTPRIMARY),
                                  ),
                                );
                              }),
                            ),
                            const Icon(Icons.edit_calendar_rounded, size: 16, color: Color(AppColors.TEXTSECONDARY)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.addressController,
            label: 'Address',
            hint: 'e.g. 35/111-A, Court Road, Thuckalay',
            icon: Icons.location_on_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildItemsFormCard(BuildContext context, QuotationController controller) {
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
              const Expanded(
                child: Text(
                  'Products / Services (A4 Sheet Limit)',
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
          // Input row for adding a new item
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 5,
                child: _buildTextField(
                  controller: controller.itemProductController,
                  label: 'Product / Service Name',
                  hint: 'e.g. Laptop keyboard repair',
                  icon: Icons.build_rounded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: _buildTextField(
                  controller: controller.itemQuantityController,
                  label: 'Qty',
                  hint: '1',
                  icon: Icons.numbers_rounded,
                  isNumber: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: _buildTextField(
                  controller: controller.itemPriceController,
                  label: 'Price (₹)',
                  hint: 'e.g. 3500',
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Currently Added Items List
          Obx(() {
            if (controller.items.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.solid),
                ),
                child: const Center(
                  child: Text(
                    'No products added yet. Use the form above to add items.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(AppColors.TEXTSECONDARY),
                      fontStyle: FontStyle.italic,
                    ),
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
                  for (int index = 0; index < controller.items.length; index++) ...[
                    if (index > 0) const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(AppColors.PRIMARY),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.items[index].productName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(AppColors.TEXTPRIMARY),
                                  ),
                                ),
                                if (controller.items[index].quantity > 1)
                                  Text(
                                    'Qty: ${controller.items[index].quantity} × ${_formatCurrency(controller.items[index].price)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(AppColors.TEXTSECONDARY),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            _formatCurrency(controller.items[index].amount, showSign: true),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            onPressed: () => controller.removeItem(index),
                            icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFEF4444)),
                            tooltip: 'Remove item',
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

  Widget _buildGstFormCard(BuildContext context, QuotationController controller) {
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
                  children: [
                    const Text(
                      'Enable GST Calculation',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(AppColors.TEXTPRIMARY),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 160,
                      child: _buildTextField(
                        controller: controller.gstPercentageController,
                        label: 'GST Percentage (%)',
                        hint: 'e.g. 18',
                        icon: Icons.percent_rounded,
                        isNumber: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(AppColors.TEXTSECONDARY),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: isNumber ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(AppColors.TEXTPRIMARY),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(AppColors.HINTTEXT),
            ),
            prefixIcon: Icon(icon, size: 18, color: const Color(AppColors.TEXTSECONDARY)),
            prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
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

  Widget _buildPreviewSection(BuildContext context, QuotationController controller) {
    return Container(
      color: const Color(0xFFF1F5F9),
      child: Column(
        children: [
          // Preview Top Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.preview_rounded, color: Color(AppColors.PRIMARY), size: 18),
                      const SizedBox(width: 6),
                      const Flexible(
                        child: Text(
                          'Quotation Preview (A4)',
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
                    ElevatedButton.icon(
                      onPressed: () => controller.printQuotationPdf(),
                      icon: const Icon(Icons.print_rounded, size: 16),
                      label: Text('Print', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
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
                          // 1. Quotation Header (Logo & Contact Info)
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
      ),
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
                  'QUOTATION',
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

  Widget _buildDocumentCustomerDetails(QuotationController controller) {
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
                  Obx(() {
                    if (controller.quotationNumber.value.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Quotation No :   ${controller.quotationNumber.value}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    );
                  }),
                  Obx(() => Text(
                        'Date :   ${_formatDate(controller.currentDate.value)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                  const SizedBox(height: 6),
                  Obx(() => Text(
                        'Valid upto :   ${_formatDate(controller.validUptoDate.value)}',
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

  Widget _buildDocumentItemsTable(QuotationController controller) {
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
                child: Text('Reason / Description', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black)),
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
                  'No quotation items listed',
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

  Widget _buildDocumentTotalsBlock(QuotationController controller) {
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

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  String _formatCurrency(double amount, {bool showSign = false}) {
    final intVal = amount.round();
    final str = intVal.abs().toString();
    String formatted = '';
    int len = str.length;
    if (len <= 3) {
      formatted = str;
    } else {
      formatted = str.substring(len - 3);
      int rem = len - 3;
      while (rem > 0) {
        if (rem >= 2) {
          formatted = '${str.substring(rem - 2, rem)},$formatted';
          rem -= 2;
        } else {
          formatted = '${str.substring(0, 1)},$formatted';
          rem -= 1;
        }
      }
    }
    if (intVal < 0) {
      formatted = '-$formatted';
    }
    if (showSign && intVal > 0) {
      return '+Rs. $formatted';
    }
    return 'Rs. $formatted';
  }
}
