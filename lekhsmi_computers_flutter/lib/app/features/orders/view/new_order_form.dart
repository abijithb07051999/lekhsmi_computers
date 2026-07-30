import 'package:flutter/material.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import 'package:lekhsmi_computers_flutter/app/features/orders/controller/orders_controller.dart';

class _ComplaintRow {
  final String id = UniqueKey().toString();
  final TextEditingController controller = TextEditingController();

  void dispose() {
    controller.dispose();
  }
}

class NewOrderFormView extends StatefulWidget {
  const NewOrderFormView({super.key});

  @override
  State<NewOrderFormView> createState() => _NewOrderFormViewState();
}

typedef OrdersView = NewOrderFormView;

class _NewOrderFormViewState extends State<NewOrderFormView> {
  final OrdersController controller = Get.put(OrdersController());

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phone1Ctrl = TextEditingController();
  final _phone2Ctrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  final List<_ComplaintRow> _complaintRows = [_ComplaintRow()];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phone1Ctrl.dispose();
    _phone2Ctrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _amountCtrl.dispose();
    for (final r in _complaintRows) {
      r.dispose();
    }
    super.dispose();
  }

  void _addComplaintRow() {
    setState(() {
      _complaintRows.add(_ComplaintRow());
    });
  }

  void _removeComplaintRow(int index) {
    if (_complaintRows.length <= 1) return;
    setState(() {
      final removed = _complaintRows.removeAt(index);
      removed.dispose();
    });
  }

  void _resetForm() {
    setState(() {
      _nameCtrl.clear();
      _phone1Ctrl.clear();
      _phone2Ctrl.clear();
      _emailCtrl.clear();
      _addressCtrl.clear();
      _amountCtrl.clear();
      _selectedDate = DateTime.now();
      for (final r in _complaintRows) {
        r.dispose();
      }
      _complaintRows.clear();
      _complaintRows.add(_ComplaintRow());
    });
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await SaaSDatePicker.show(
      context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime d) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final day = d.day.toString().padLeft(2, '0');
    final mon = months[d.month - 1];
    return '$day $mon, ${d.year}';
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final complaints = _complaintRows
        .map((r) => r.controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    if (complaints.isEmpty) {
      AppNotification.warning('Missing Complaints', 'Please add at least one complaint or repair item.');
      return;
    }

    final int phone1 = int.tryParse(_phone1Ctrl.text.trim()) ?? 0;
    final int? phone2 = _phone2Ctrl.text.trim().isNotEmpty
        ? int.tryParse(_phone2Ctrl.text.trim())
        : null;
    final int amount = int.tryParse(_amountCtrl.text.trim()) ?? 0;

    final success = await controller.createNewOrder(
      customerName: _nameCtrl.text.trim(),
      contact1: phone1,
      contact2: phone2,
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      address: _addressCtrl.text.trim(),
      date: _selectedDate,
      complaints: complaints,
      amount: amount,
    );

    if (success) {
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // 1. Top Header Bar (White Card Bar)
          _buildTitleSection(),
          // 2. Main Content Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
              child: Container(
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
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Col: Customer Details & Amount
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customer Information',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(AppColors.TEXTPRIMARY),
                                        ),
                                      ),
                                      const SizedBox(height: 20),

                                      _buildTextField(
                                        controller: _nameCtrl,
                                        label: 'Customer Name',
                                        icon: Icons.person_outline,
                                        validator: (val) => val == null || val.trim().isEmpty ? 'Enter customer name' : null,
                                      ),
                                      const SizedBox(height: 16),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildTextField(
                                              controller: _phone1Ctrl,
                                              label: 'Primary Phone',
                                              icon: Icons.phone_outlined,
                                              keyboardType: TextInputType.number,
                                              validator: (val) {
                                                if (val == null || val.trim().isEmpty) return 'Required';
                                                if (int.tryParse(val.trim()) == null) return 'Numbers only';
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: _buildTextField(
                                              controller: _phone2Ctrl,
                                              label: 'Secondary Phone (Optional)',
                                              icon: Icons.phone_android_outlined,
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      _buildTextField(
                                        controller: _emailCtrl,
                                        label: 'Email Address (Optional)',
                                        icon: Icons.email_outlined,
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                      const SizedBox(height: 16),

                                      _buildTextField(
                                        controller: _addressCtrl,
                                        label: 'Customer Address',
                                        icon: Icons.location_on_outlined,
                                        maxLines: 2,
                                        validator: (val) => val == null || val.trim().isEmpty ? 'Enter customer address' : null,
                                      ),
                                      const SizedBox(height: 20),

                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Order Date',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color(AppColors.TEXTSECONDARY),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),

                                                InkWell(
                                                  onTap: () => _pickDate(context),
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                                    decoration: BoxDecoration(
                                                      color: const Color(AppColors.WHITE),
                                                      borderRadius: BorderRadius.circular(12),
                                                      border: Border.all(color: const Color(0xFFCBD5E1)),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(Icons.calendar_today_outlined, size: 18, color: Color(AppColors.PRIMARY)),
                                                            const SizedBox(width: 12),
                                                            Text(
                                                              _formatDate(_selectedDate),
                                                              style: GoogleFonts.inter(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w600,
                                                                color: const Color(AppColors.TEXTPRIMARY),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Icon(Icons.arrow_drop_down, color: Color(AppColors.TEXTSECONDARY)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            flex: 5,
                                            child: _buildTextField(
                                              controller: _amountCtrl,
                                              label: 'Price / Amount (₹)',
                                              icon: Icons.currency_rupee_outlined,
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),

                              // Right Col: Complaints & Requirements
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Complaints / Requirements',
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(AppColors.TEXTPRIMARY),
                                            ),
                                          ),
                                          TextButton.icon(
                                            onPressed: _addComplaintRow,
                                            icon: const Icon(Icons.add_circle_outline, size: 18),
                                            label: Text('Add Complaint', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Specify all reported issues or services required for this order',
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.8),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: _complaintRows.length,
                                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                                        itemBuilder: (context, idx) {
                                          final row = _complaintRows[idx];
                                          return Row(
                                            key: ValueKey(row.id),
                                            children: [
                                              Container(
                                                width: 28,
                                                height: 28,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  '${idx + 1}',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color(AppColors.PRIMARY),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: row.controller,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    color: const Color(AppColors.TEXTPRIMARY),
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintText: 'e.g., Laptop Keyboard Complaint, OS Installation',
                                                    hintStyle: GoogleFonts.inter(
                                                      color: const Color(AppColors.HINTTEXT),
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                    filled: true,
                                                    fillColor: const Color(AppColors.WHITE),
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                      borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                      borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                      borderSide: const BorderSide(color: Color(AppColors.PRIMARY), width: 1.5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              IconButton(
                                                onPressed: _complaintRows.length > 1 ? () => _removeComplaintRow(idx) : null,
                                                icon: const Icon(Icons.delete_outline, color: Color(0xFFDC2626), size: 20),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // 3. Fixed Bottom Action Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: _resetForm,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'Reset Form',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(AppColors.TEXTSECONDARY),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Obx(() {
                            return ElevatedButton.icon(
                              onPressed: controller.isLoading.value ? null : _submitForm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(AppColors.PRIMARY),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              icon: controller.isLoading.value
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : const Icon(Icons.check_circle_outline, size: 20),
                              label: Text(
                                controller.isLoading.value ? 'Creating Order...' : 'Create Order',
                                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'New Service / Repair Order',
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
                  'SERVICE REGISTRATION',
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.tag,
                      size: 14,
                      color: const Color(AppColors.PRIMARY).withValues(alpha: 0.8),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'ID: ${controller.generateOrderId()}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
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
                  onTap: _resetForm,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(AppColors.TEXTSECONDARY),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(AppColors.TEXTPRIMARY),
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: const Color(AppColors.PRIMARY)),
            filled: true,
            fillColor: const Color(AppColors.WHITE),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(AppColors.PRIMARY), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

