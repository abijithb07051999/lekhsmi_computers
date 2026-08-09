import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/app/features/orders/controller/orders_controller.dart';
import 'new_order_form.dart';

class NewOrderFormMobileView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController phone1Ctrl;
  final TextEditingController phone2Ctrl;
  final TextEditingController emailCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController amountCtrl;
  final DateTime selectedDate;
  final List<ComplaintRow> complaintRows;
  final Future<void> Function(BuildContext) onPickDate;
  final VoidCallback onAddComplaintRow;
  final ValueChanged<int> onRemoveComplaintRow;
  final VoidCallback onSubmitForm;
  final VoidCallback onResetForm;
  final OrdersController controller;

  const NewOrderFormMobileView({
    super.key,
    required this.formKey,
    required this.nameCtrl,
    required this.phone1Ctrl,
    required this.phone2Ctrl,
    required this.emailCtrl,
    required this.addressCtrl,
    required this.amountCtrl,
    required this.selectedDate,
    required this.complaintRows,
    required this.onPickDate,
    required this.onAddComplaintRow,
    required this.onRemoveComplaintRow,
    required this.onSubmitForm,
    required this.onResetForm,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CRITICAL FIX: Allow keyboard to scroll the view!
      resizeToAvoidBottomInset: true, 
      backgroundColor: Colors.transparent,
      body: Column(
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
                        'New Service Order',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Register a new customer device',
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
                  color: const Color(0xFFF1F5F9),
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: onResetForm,
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.refresh_rounded,
                        color: Color(0xFF64748B),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Container(
              color: const Color(0xFFF8FAFC),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Card 1: Customer Information ─────────────────────────
                      _buildEliteCard(
                        title: 'Customer Information',
                        icon: Icons.person_rounded,
                        children: [
                          _buildEliteTextField(
                            controller: nameCtrl,
                            label: 'Customer Name',
                            icon: Icons.badge_rounded,
                            validator: (val) => val == null || val.trim().isEmpty ? 'Enter customer name' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildEliteTextField(
                            controller: phone1Ctrl,
                            label: 'Primary Contact Number',
                            icon: Icons.phone_rounded,
                            keyboardType: TextInputType.phone,
                            validator: (val) => val == null || val.trim().isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildEliteTextField(
                            controller: phone2Ctrl,
                            label: 'Secondary Contact (Optional)',
                            icon: Icons.phone_android_rounded,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 12),
                          _buildEliteTextField(
                            controller: emailCtrl,
                            label: 'Email Address (Optional)',
                            icon: Icons.email_rounded,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),
                          _buildEliteTextField(
                            controller: addressCtrl,
                            label: 'Customer Address',
                            icon: Icons.location_on_rounded,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ── Card 2: Date & Pricing ───────────────────────────────
                      _buildEliteCard(
                        title: 'Date & Estimated Cost',
                        icon: Icons.payments_rounded,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Registration Date',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => onPickDate(context),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.calendar_month_rounded, size: 20, color: Color(0xFF0284C7)),
                                            const SizedBox(width: 12),
                                            Flexible(
                                              child: Text(
                                                NewOrderFormDialogs.formatDate(selectedDate),
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: const Color(0xFF0F172A),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.expand_more_rounded, color: Color(0xFF94A3B8)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildEliteTextField(
                            controller: amountCtrl,
                            label: 'Estimated Price (₹)',
                            icon: Icons.currency_rupee_rounded,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ── Card 3: Complaints / Requirements ────────────────────
                      _buildEliteCard(
                        title: 'Complaints / Requirements',
                        icon: Icons.build_circle_rounded,
                        actionWidget: InkWell(
                          onTap: onAddComplaintRow,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0284C7).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.add_rounded, size: 16, color: Color(0xFF0284C7)),
                                const SizedBox(width: 4),
                                Text(
                                  'Add Item',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0284C7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        children: [
                          for (int i = 0; i < complaintRows.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _buildEliteTextField(
                                      controller: complaintRows[i].controller,
                                      label: 'Complaint / Requirement #${i + 1}',
                                      icon: Icons.handyman_rounded,
                                    ),
                                  ),
                                  if (complaintRows.length > 1) ...[
                                    const SizedBox(width: 12),
                                    Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEF2F2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.remove_rounded, color: Color(0xFFDC2626)),
                                        onPressed: () => onRemoveComplaintRow(i),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ── Submit & Reset buttons ───────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: _buildEliteSubmitButton(
                              title: 'Register Order',
                              onTap: onSubmitForm,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
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

  // ===========================================================================
  // ELITE WIDGET HELPERS
  // ===========================================================================
  Widget _buildEliteCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
    Widget? actionWidget,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(icon, size: 20, color: const Color(0xFF0F172A)),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (actionWidget != null) actionWidget,
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildEliteTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Icon(icon, color: const Color(0xFF94A3B8), size: 20),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0284C7), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEliteSubmitButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 56,
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
              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.5,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
