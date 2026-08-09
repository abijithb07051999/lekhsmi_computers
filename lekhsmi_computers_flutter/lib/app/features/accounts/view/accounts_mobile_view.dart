import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import '../controller/accounts_controller.dart';

class AccountsMobileView extends StatefulWidget {
  const AccountsMobileView({super.key});

  @override
  State<AccountsMobileView> createState() => _AccountsMobileViewState();
}

class _AccountsMobileViewState extends State<AccountsMobileView> {
  final AccountsController controller = Get.find<AccountsController>();
  String _selectedType = 'Income';
  DateTime _selectedDate = DateTime.now();
  final _amountCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _reasonCtrl.dispose();
    super.dispose();
  }

  void _resetForm() {
    setState(() {
      _amountCtrl.clear();
      _reasonCtrl.clear();
      _selectedDate = DateTime.now();
      _selectedType = 'Income';
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
    final day = d.day.toString().padLeft(2, '0');
    final mon = months[d.month - 1];
    return '$day $mon, ${d.year}';
  }

  String _formatCurrency(
    int amount, {
    bool showSign = true,
    bool isExpense = false,
  }) {
    final absVal = amount.abs();
    final s = absVal.toString();
    String result;
    if (s.length <= 3) {
      result = s;
    } else {
      String tail = s.substring(s.length - 3);
      int i = s.length - 3;
      while (i > 0) {
        final end = i;
        final start = (i - 2) < 0 ? 0 : i - 2;
        tail = '${s.substring(start, end)},$tail';
        i -= 2;
      }
      result = tail;
    }

    if (!showSign) return '₹$result';
    return isExpense ? '-₹$result' : '+₹$result';
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    final int amount = int.tryParse(_amountCtrl.text.trim()) ?? 0;
    if (amount <= 0) {
      AppNotification.warning(
        'Invalid Amount',
        'Please enter a valid positive amount.',
      );
      return;
    }

    final success = await controller.addEntry(
      type: _selectedType,
      amount: amount,
      date: _selectedDate,
      reason: _reasonCtrl.text.trim(),
    );

    if (success) {
      _resetForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildPhoneAccountsView(context);
  }

  Widget _buildPhoneAccountsView(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: const Color(AppColors.WHITE),
            elevation: 1,
            shadowColor: Colors.black.withValues(alpha: 0.04),
            automaticallyImplyLeading: false,
            title: Text(
              'Income & Expense',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: Color(AppColors.PRIMARY),
                  size: 20,
                ),
                onPressed: () => controller.fetchAccounts(),
                tooltip: 'Refresh',
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(child: _buildPhoneTransactionForm()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              child: _buildMobileAccountsCardsSection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneTransactionForm() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'New Transaction Entry',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTypeButton(
                      'Income',
                      const Color(0xFF10B981),
                      Icons.arrow_downward,
                    ),
                  ),
                  Expanded(
                    child: _buildTypeButton(
                      'Expense',
                      const Color(0xFFEF4444),
                      Icons.arrow_upward,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: Color(AppColors.PRIMARY),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatDate(_selectedDate),
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(AppColors.TEXTPRIMARY),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _amountCtrl,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      color: const Color(AppColors.TEXTPRIMARY),
                      fontWeight: FontWeight.w700,
                    ),
                    validator:
                        (val) =>
                            val == null || val.trim().isEmpty
                                ? 'Amount req'
                                : null,
                    decoration: InputDecoration(
                      hintText: 'Amount (₹)',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(AppColors.HINTTEXT),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _reasonCtrl,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
              validator:
                  (val) =>
                      val == null || val.trim().isEmpty
                          ? 'Enter reason / description'
                          : null,
              decoration: InputDecoration(
                hintText: 'e.g., Laptop repair sale, Store rent...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(AppColors.HINTTEXT),
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final isInc = _selectedType == 'Income';
              final btnColor =
                  isInc ? const Color(0xFF10B981) : const Color(0xFFEF4444);
              return SizedBox(
                height: 46,
                child: ElevatedButton.icon(
                  onPressed: controller.isLoading.value ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: Text(
                    isInc ? 'Add Income Entry' : 'Add Expense Entry',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(String title, Color activeColor, IconData icon) {
    final isSelected = _selectedType == title;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = title;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14,
              color:
                  isSelected
                      ? Colors.white
                      : const Color(AppColors.TEXTSECONDARY),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color:
                    isSelected
                        ? Colors.white
                        : const Color(AppColors.TEXTSECONDARY),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileAccountsCardsSection() {
    return Obx(() {
      final list =
          _selectedType == 'Income' ? controller.incomes : controller.expenses;
      final isIncome = _selectedType == 'Income';
      final headerColor =
          isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444);

      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
          ),
        );
      }

      if (list.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isIncome
                      ? Icons.savings_outlined
                      : Icons.receipt_long_outlined,
                  size: 44,
                  color: const Color(
                    AppColors.TEXTSECONDARY,
                  ).withValues(alpha: 0.3),
                ),
                const SizedBox(height: 12),
                Text(
                  isIncome
                      ? 'No income entries recorded'
                      : 'No expense entries recorded',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(AppColors.TEXTSECONDARY),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: headerColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$_selectedType History',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: headerColor,
                  ),
                ),
                Text(
                  '${list.length} entries',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: headerColor,
                  ),
                ),
              ],
            ),
          ),
          for (final item in list) ...[
            _buildMobileAccountCard(
              date: isIncome ? (item as Income).date : (item as Expense).date,
              reason:
                  isIncome ? (item as Income).reason : (item as Expense).reason,
              amount:
                  isIncome ? (item as Income).amount : (item as Expense).amount,
              isIncome: isIncome,
              onDelete:
                  () =>
                      isIncome
                          ? controller.deleteIncome(item as Income)
                          : controller.deleteExpense(item as Expense),
            ),
          ],
        ],
      );
    });
  }

  Widget _buildMobileAccountCard({
    required DateTime date,
    required String reason,
    required int amount,
    required bool isIncome,
    required VoidCallback onDelete,
  }) {
    final amountColor =
        isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final prefix = isIncome ? '+' : '-';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reason,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: const Color(AppColors.TEXTPRIMARY),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(date),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(AppColors.TEXTSECONDARY),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: amountColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$prefix${_formatCurrency(amount, showSign: false)}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: amountColor,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(AppColors.TEXTSECONDARY),
                  size: 18,
                ),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
