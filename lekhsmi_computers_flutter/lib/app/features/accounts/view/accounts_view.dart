import 'package:flutter/material.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import '../controller/accounts_controller.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({super.key});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
  final AccountsController controller = Get.put(AccountsController());

  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedType = 'Income';

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
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final day = d.day.toString().padLeft(2, '0');
    final mon = months[d.month - 1];
    return '$day $mon, ${d.year}';
  }

  String _formatCurrency(int amount, {bool showSign = true, bool isExpense = false}) {
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
      AppNotification.warning('Invalid Amount', 'Please enter a valid positive amount.');
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
              child: Column(
                children: [
                  // Top Summary Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing cash flow for ${controller.currentMonthName}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: const Color(AppColors.TEXTSECONDARY),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(() {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildSummaryCard(
                              title: 'Total Income',
                              amountText: _formatCurrency(controller.totalIncome, showSign: true, isExpense: false),
                              icon: Icons.trending_up,
                              color: const Color(0xFF10B981),
                              bgColor: const Color(0xFFECFDF5),
                            ),
                            const SizedBox(width: 12),
                            _buildSummaryCard(
                              title: 'Total Expense',
                              amountText: _formatCurrency(controller.totalExpense, showSign: true, isExpense: true),
                              icon: Icons.trending_down,
                              color: const Color(0xFFEF4444),
                              bgColor: const Color(0xFFFEF2F2),
                            ),
                            const SizedBox(width: 12),
                            _buildSummaryCard(
                              title: 'Net Balance',
                              amountText: _formatCurrency(controller.netBalance, showSign: false),
                              icon: Icons.account_balance_wallet_outlined,
                              color: const Color(AppColors.PRIMARY),
                              bgColor: const Color(0xFFEFF6FF),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 2. Simple Transaction Form Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(AppColors.WHITE),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Type Selector (Income / Expense)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Entry Type',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(AppColors.TEXTSECONDARY),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 48,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    _buildTypeButton('Income', const Color(0xFF10B981), Icons.arrow_downward),
                                    _buildTypeButton('Expense', const Color(0xFFEF4444), Icons.arrow_upward),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),

                          // Date Picker Button
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(AppColors.TEXTSECONDARY),
                                ),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () => _pickDate(context),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: 48,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFCBD5E1)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined, size: 16, color: Color(AppColors.PRIMARY)),
                                      const SizedBox(width: 10),
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
                            ],
                          ),
                          const SizedBox(width: 16),

                          // Amount Field
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount (₹)',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(AppColors.TEXTSECONDARY),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _amountCtrl,
                                  keyboardType: TextInputType.number,
                                  style: GoogleFonts.inter(fontSize: 13.5, color: const Color(AppColors.TEXTPRIMARY)),
                                  validator: (val) {
                                    if (val == null || val.trim().isEmpty) return 'Enter amount';
                                    if (int.tryParse(val.trim()) == null) return 'Numbers only';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'e.g., 5000',
                                    hintStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: const Color(AppColors.HINTTEXT)),
                                    prefixText: '₹ ',
                                    prefixStyle: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY)),
                                    filled: true,
                                    fillColor: const Color(0xFFF8FAFC),
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
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Reason Field
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reason / Description',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(AppColors.TEXTSECONDARY),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: _reasonCtrl,
                                  style: GoogleFonts.inter(fontSize: 13.5, color: const Color(AppColors.TEXTPRIMARY)),
                                  validator: (val) => val == null || val.trim().isEmpty ? 'Enter reason / description' : null,
                                  decoration: InputDecoration(
                                    hintText: 'e.g., Laptop repair sale, Electricity bill, Store rent...',
                                    hintStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: const Color(AppColors.HINTTEXT)),
                                    filled: true,
                                    fillColor: const Color(0xFFF8FAFC),
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
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Save Button
                          Padding(
                            padding: const EdgeInsets.only(top: 23),
                            child: Obx(() {
                              final isInc = _selectedType == 'Income';
                              final btnColor = isInc ? const Color(0xFF10B981) : const Color(0xFFEF4444);

                              return SizedBox(
                                height: 48,
                                child: ElevatedButton.icon(
                                  onPressed: controller.isLoading.value ? null : _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: btnColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 0,
                                  ),
                                  icon: controller.isLoading.value
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                        )
                                      : const Icon(Icons.add_circle_outline, size: 18),
                                  label: Text(
                                    'Save $_selectedType',
                                    style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Two Separate Tables Side by Side (Left: Income, Right: Expense)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT SIDE: INCOME TABLE
                        Expanded(
                          child: _buildTableCard(
                            title: 'Income Table',
                            subtitle: 'Revenues & sales income',
                            icon: Icons.trending_up,
                            headerColor: const Color(0xFF10B981),
                            isIncome: true,
                          ),
                        ),
                        const SizedBox(width: 24),

                        // RIGHT SIDE: EXPENSE TABLE
                        Expanded(
                          child: _buildTableCard(
                            title: 'Expense Table',
                            subtitle: 'Store costs & bills',
                            icon: Icons.trending_down,
                            headerColor: const Color(0xFFEF4444),
                            isIncome: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
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
                'Income / Expense Cash Flow',
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
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'CASH FLOW MANAGEMENT',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF10B981),
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
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(AppColors.TEXTSECONDARY),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDate(DateTime.now()),
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
                  onTap: () => controller.fetchAccounts(),
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
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? Colors.white : const Color(AppColors.TEXTSECONDARY),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? Colors.white : const Color(AppColors.TEXTSECONDARY),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String amountText,
    required IconData icon,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(AppColors.TEXTSECONDARY),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                amountText,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color headerColor,
    required bool isIncome,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Card Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: headerColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: headerColor, size: 20),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(AppColors.TEXTPRIMARY),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Obx(() {
                  final list = isIncome ? controller.incomes : controller.expenses;
                  final total = isIncome ? controller.totalIncome : controller.totalExpense;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: headerColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${list.length} entries • ${_formatCurrency(total, showSign: false)}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: headerColor,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),

          // Custom Column Headers (No. | Date | Reason | Amount | Action)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: const Color(0xFFF8FAFC),
            child: Row(
              children: [
                SizedBox(
                  width: 44,
                  child: Text('No.', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                ),
                SizedBox(
                  width: 100,
                  child: Text('Date', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                ),
                Expanded(
                  child: Text('Reason / Description', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                ),
                SizedBox(
                  width: 110,
                  child: Text('Amount (₹)', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                ),
                SizedBox(
                  width: 48,
                  child: Text('Action', textAlign: TextAlign.center, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                ),
              ],
            ),
          ),

          // Table Rows List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: headerColor),
                );
              }

              final list = isIncome ? controller.incomes : controller.expenses;
              if (list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isIncome ? Icons.savings_outlined : Icons.receipt_long_outlined,
                        size: 44,
                        color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isIncome ? 'No income entries recorded' : 'No expense entries recorded',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(AppColors.TEXTSECONDARY),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, index) {
                  final item = list[index];
                  if (isIncome) {
                    final incomeItem = item as Income;
                    return _buildTableRow(
                      index: index + 1,
                      date: incomeItem.date,
                      reason: incomeItem.reason,
                      amount: incomeItem.amount,
                      isIncome: true,
                      onDelete: () => controller.deleteIncome(incomeItem),
                    );
                  } else {
                    final expenseItem = item as Expense;
                    return _buildTableRow(
                      index: index + 1,
                      date: expenseItem.date,
                      reason: expenseItem.reason,
                      amount: expenseItem.amount,
                      isIncome: false,
                      onDelete: () => controller.deleteExpense(expenseItem),
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow({
    required int index,
    required DateTime date,
    required String reason,
    required int amount,
    required bool isIncome,
    required VoidCallback onDelete,
  }) {
    final amountColor = isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final prefix = isIncome ? '+' : '-';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              '$index',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              _formatDate(date),
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(AppColors.TEXTSECONDARY),
              ),
            ),
          ),
          Expanded(
            child: Text(
              reason,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 110,
            child: Text(
              '$prefix${_formatCurrency(amount, showSign: false)}',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: amountColor,
              ),
            ),
          ),
          SizedBox(
            width: 48,
            child: IconButton(
              onPressed: onDelete,
              tooltip: 'Delete Entry',
              icon: const Icon(Icons.delete_outline, size: 18, color: Color(0xFF94A3B8)),
              hoverColor: const Color(0xFFFEF2F2),
            ),
          ),
        ],
      ),
    );
  }
}
