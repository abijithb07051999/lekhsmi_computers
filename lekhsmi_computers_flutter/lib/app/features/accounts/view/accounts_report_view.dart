import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/utils/responsive_utils.dart';
import 'accounts_report_mobile_view.dart';
import '../controller/accounts_controller.dart';

class AccountsReportView extends StatefulWidget {
  const AccountsReportView({super.key});

  @override
  State<AccountsReportView> createState() => _AccountsReportViewState();
}

class _AccountsReportViewState extends State<AccountsReportView> {
  final AccountsController controller = Get.put(AccountsController());

  @override
  void initState() {
    super.initState();
    controller.fetchAnnualReport();
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

  void _showMonthDetailsPopup(BuildContext context, MonthlyReportItem item) {
    showDialog(
      context: context,
      builder: (context) => MonthDetailsDialog(
        item: item,
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isPhone(context)) {
      return const AccountsReportMobileView();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // 1. Top White Header Bar
          _buildTitleSection(),
          // 2. Main Content Area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
              child: Column(
                children: [
                  // Top Description & YTD Cards Row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return Text(
                            'Showing ${controller.selectedReportYear.value} financial performance & month-over-month growth',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(AppColors.TEXTSECONDARY),
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                        // YTD Financial Cards
                        Obx(() {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildSummaryCard(
                                title: 'YTD Income',
                                amountText: _formatCurrency(
                                  controller.ytdTotalIncome,
                                  showSign: true,
                                  isExpense: false,
                                ),
                                icon: Icons.trending_up,
                                color: const Color(0xFF10B981),
                                bgColor: const Color(0xFFECFDF5),
                              ),
                              const SizedBox(width: 12),
                              _buildSummaryCard(
                                title: 'YTD Expense',
                                amountText: _formatCurrency(
                                  controller.ytdTotalExpense,
                                  showSign: true,
                                  isExpense: true,
                                ),
                                icon: Icons.trending_down,
                                color: const Color(0xFFEF4444),
                                bgColor: const Color(0xFFFEF2F2),
                              ),
                              const SizedBox(width: 12),
                              _buildSummaryCard(
                                title: 'YTD Net Profit',
                                amountText: _formatCurrency(
                                  controller.ytdNetProfit,
                                  showSign: false,
                                ),
                                icon: Icons.auto_graph_rounded,
                                color: const Color(AppColors.PRIMARY),
                                bgColor: const Color(0xFFEFF6FF),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Month-over-Month Comparison Table Card
                  Expanded(
                    child: Container(
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
                          // Card Header Bar
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Color(0xFFF1F5F9)),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          AppColors.PRIMARY,
                                        ).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.analytics_outlined,
                                        color: Color(AppColors.PRIMARY),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(() {
                                          return Text(
                                            '${controller.selectedReportYear.value} Monthly Financial Performance',
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(
                                                AppColors.TEXTPRIMARY,
                                              ),
                                            ),
                                          );
                                        }),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Click "View" on any month to inspect all income and expense entries',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: const Color(
                                              AppColors.TEXTSECONDARY,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      AppColors.PRIMARY,
                                    ).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Obx(() {
                                    final count =
                                        controller.annualReportList.length;
                                    final yr =
                                        controller.selectedReportYear.value;
                                    return Text(
                                      '$count ${count == 1 ? "Month" : "Months"} • $yr Calendar',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(AppColors.PRIMARY),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),

                          // Table Header Row
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            color: const Color(0xFFF8FAFC),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text(
                                    'No.',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: const Color(
                                        AppColors.TEXTSECONDARY,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Month',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: const Color(
                                        AppColors.TEXTSECONDARY,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Total Income',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: const Color(
                                        AppColors.TEXTSECONDARY,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Total Expense',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: const Color(
                                        AppColors.TEXTSECONDARY,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Net Profit / Loss',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: const Color(
                                        AppColors.TEXTSECONDARY,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    'Status',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: const Color(
                                        AppColors.TEXTSECONDARY,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      'Action',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Color(
                                          AppColors.TEXTSECONDARY,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Table Rows
                          Expanded(
                            child: Obx(() {
                              if (controller.annualReportList.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(AppColors.PRIMARY),
                                  ),
                                );
                              }

                              return ListView.separated(
                                itemCount: controller.annualReportList.length,
                                separatorBuilder: (_, _) => const Divider(
                                  height: 1,
                                  color: Color(0xFFF1F5F9),
                                ),
                                itemBuilder: (context, index) {
                                  final item =
                                      controller.annualReportList[index];
                                  return _buildMonthRow(context, item);
                                },
                              );
                            }),
                          ),
                        ],
                      ),
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
                'Annual Accounts & Profit Report',
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
              // Year Selector Dropdown Pill
              Obx(() {
                final years = controller.availableYears;
                final currentSel = controller.selectedReportYear.value;

                return Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(
                      AppColors.PRIMARY,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(
                        AppColors.PRIMARY,
                      ).withValues(alpha: 0.3),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: years.contains(currentSel)
                          ? currentSel
                          : (years.isNotEmpty ? years.first : currentSel),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: Color(AppColors.PRIMARY),
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(AppColors.PRIMARY),
                      ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      elevation: 12,
                      onChanged: (val) {
                        if (val != null) {
                          controller.changeReportYear(val);
                        }
                      },
                      items: years.map((year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 14,
                                color: Color(AppColors.PRIMARY),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$year',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
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
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => controller.fetchAnnualReport(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(AppColors.WHITE),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: Color(AppColors.TEXTPRIMARY),
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(AppColors.TEXTSECONDARY),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                amountText,
                style: TextStyle(
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

  Widget _buildMonthRow(BuildContext context, MonthlyReportItem item) {
    final bool isCurrent = item.isCurrentMonth;

    return Container(
      color: isCurrent
          ? const Color(0xFFEFF6FF).withValues(alpha: 0.5)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // No.
          SizedBox(
            width: 40,
            child: Text(
              '#${item.monthNumber}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w700,
                color: isCurrent
                    ? const Color(AppColors.PRIMARY)
                    : const Color(0xFF94A3B8),
              ),
            ),
          ),

          // Month Name
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  item.monthName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                    color: const Color(AppColors.TEXTPRIMARY),
                  ),
                ),
                if (isCurrent) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(AppColors.PRIMARY),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Income
          Expanded(
            flex: 3,
            child: Text(
              _formatCurrency(item.income, showSign: false),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF10B981),
              ),
            ),
          ),

          // Expense
          Expanded(
            flex: 3,
            child: Text(
              _formatCurrency(item.expense, showSign: false),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFFEF4444),
              ),
            ),
          ),

          // Net Profit
          Expanded(
            flex: 3,
            child: Text(
              _formatCurrency(item.netProfit, showSign: false),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: item.netProfit >= 0
                    ? const Color(AppColors.PRIMARY)
                    : const Color(0xFFEF4444),
              ),
            ),
          ),

          // Status / Profitability Badge
          Expanded(
            flex: 3,
            child: _buildStatusTag(
              item.income,
              item.expense,
              isFutureMonth: item.isFutureMonth,
            ),
          ),

          // Action / View Button
          SizedBox(
            width: 80,
            child: Center(
              child: InkWell(
                onTap: () => _showMonthDetailsPopup(context, item),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      AppColors.PRIMARY,
                    ).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(
                        AppColors.PRIMARY,
                      ).withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(AppColors.PRIMARY),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(
    int income,
    int expense, {
    required bool isFutureMonth,
  }) {
    if (isFutureMonth) {
      return const Text(
        'Upcoming ⏳',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(AppColors.TEXTSECONDARY),
        ),
      );
    }

    if (income == 0 && expense == 0) {
      return const Text(
        'No Activity ⚪',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(AppColors.TEXTSECONDARY),
        ),
      );
    }

    final int net = income - expense;
    if (net > 0) {
      return const Text(
        'Profitable 🟢',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color(0xFF10B981),
        ),
      );
    } else if (net < 0) {
      return const Text(
        'Loss 🔴',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color(0xFFEF4444),
        ),
      );
    } else {
      return const Text(
        'Break Even ⚪',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color(AppColors.PRIMARY),
        ),
      );
    }
  }
}

class MonthDetailsDialog extends StatefulWidget {
  final MonthlyReportItem item;
  final AccountsController controller;

  const MonthDetailsDialog({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  State<MonthDetailsDialog> createState() => _MonthDetailsDialogState();
}

class _MonthDetailsDialogState extends State<MonthDetailsDialog> {
  int _selectedTabIndex = 0; // 0 for Income, 1 for Expense

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
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

  @override
  Widget build(BuildContext context) {
    final isPhone = ResponsiveUtils.isPhone(context);
    final incomes = widget.controller.getIncomesForMonth(widget.item.year, widget.item.monthNumber);
    final expenses = widget.controller.getExpensesForMonth(widget.item.year, widget.item.monthNumber);
    final maxH = MediaQuery.of(context).size.height * 0.90;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isPhone ? 14 : 32, vertical: 16),
      child: Container(
        width: isPhone ? 400 : 950,
        height: isPhone ? maxH : 680,
        decoration: BoxDecoration(
          color: const Color(AppColors.WHITE),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Elite Centered Header
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: isPhone ? 20 : 28,
                    right: isPhone ? 20 : 28,
                    top: isPhone ? 32 : 40,
                    bottom: isPhone ? 20 : 24,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(AppColors.WHITE),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    children: [
                      // Icon
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(AppColors.PRIMARY).withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: Color(AppColors.PRIMARY),
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      Text(
                        '${widget.item.monthName} ${widget.item.year} Breakdown',
                        style: TextStyle(
                          fontSize: isPhone ? 20 : 24,
                          fontWeight: FontWeight.w800,
                          color: const Color(AppColors.TEXTPRIMARY),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Subtitle
                      Text(
                        'Complete chronological logs of all income and expense entries',
                        style: TextStyle(
                          fontSize: isPhone ? 13 : 14,
                          color: const Color(AppColors.TEXTSECONDARY),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Close button
                Positioned(
                  top: 16,
                  right: 16,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Color(AppColors.TEXTSECONDARY),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Summary Badges Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: isPhone ? 20 : 28, vertical: 8),
              width: double.infinity,
              child: Wrap(
                alignment: isPhone ? WrapAlignment.spaceBetween : WrapAlignment.spaceAround,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildMiniBadge(
                    title: 'Net Profit',
                    amountText: _formatCurrency(widget.item.netProfit, showSign: false),
                    color: widget.item.netProfit >= 0 ? const Color(AppColors.PRIMARY) : const Color(0xFFEF4444),
                    bgColor: const Color(0xFFEFF6FF),
                    icon: Icons.account_balance_wallet_outlined,
                    isPhone: isPhone,
                    widthPercent: 1.0,
                  ),
                  _buildMiniBadge(
                    title: 'Income (${incomes.length})',
                    amountText: _formatCurrency(widget.item.income, showSign: true, isExpense: false),
                    color: const Color(0xFF10B981),
                    bgColor: const Color(0xFFECFDF5),
                    icon: Icons.trending_up,
                    isPhone: isPhone,
                    widthPercent: 0.47,
                  ),
                  _buildMiniBadge(
                    title: 'Expense (${expenses.length})',
                    amountText: _formatCurrency(widget.item.expense, showSign: true, isExpense: true),
                    color: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEF2F2),
                    icon: Icons.trending_down,
                    isPhone: isPhone,
                    widthPercent: 0.47,
                  ),
                ],
              ),
            ),

            // Content Area (Responsive)
            Expanded(
              child: isPhone
                  ? Column(
                      children: [
                        // Tab Bar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _selectedTabIndex = 0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _selectedTabIndex == 0 ? const Color(AppColors.WHITE) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: _selectedTabIndex == 0
                                            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Income',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: _selectedTabIndex == 0 ? FontWeight.w800 : FontWeight.w600,
                                            color: _selectedTabIndex == 0 ? const Color(0xFF10B981) : const Color(AppColors.TEXTSECONDARY),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _selectedTabIndex = 1),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: _selectedTabIndex == 1 ? const Color(AppColors.WHITE) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: _selectedTabIndex == 1
                                            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))]
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Expense',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: _selectedTabIndex == 1 ? FontWeight.w800 : FontWeight.w600,
                                            color: _selectedTabIndex == 1 ? const Color(0xFFEF4444) : const Color(AppColors.TEXTSECONDARY),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Tab Content
                        Expanded(
                          child: IndexedStack(
                            index: _selectedTabIndex,
                            children: [
                              _buildTabList(incomes, true, widget.item, isPhone),
                              _buildTabList(expenses, false, widget.item, isPhone),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          Expanded(child: _buildTransactionListCard(incomes, true, widget.item, isPhone)),
                          const SizedBox(width: 20),
                          Expanded(child: _buildTransactionListCard(expenses, false, widget.item, isPhone)),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabList(List transactions, bool isIncome, MonthlyReportItem item, bool isPhone) {
    final title = isIncome ? 'Income' : 'Expense';
    if (transactions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: _buildEmptyState('No $title transactions recorded for ${item.monthName}'),
      );
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
      itemBuilder: (context, idx) => _buildTransactionRow(transactions[idx], isIncome),
    );
  }

  Widget _buildTransactionListCard(List transactions, bool isIncome, MonthlyReportItem item, bool isPhone) {
    final title = isIncome ? 'Income' : 'Expense';
    final amount = isIncome ? item.income : item.expense;
    final color = isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final bgColor = isIncome ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2);
    final textColor = isIncome ? const Color(0xFF065F46) : const Color(0xFF991B1B);
    final icon = isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded;

    return Container(
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '$title (${transactions.length})',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: textColor),
                    ),
                  ],
                ),
                Text(
                  _formatCurrency(amount, showSign: false),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color),
                ),
              ],
            ),
          ),
          if (transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: _buildEmptyState('No $title transactions recorded for ${item.monthName}'),
            )
          else
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: transactions.length,
                separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                itemBuilder: (context, idx) => _buildTransactionRow(transactions[idx], isIncome),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(dynamic transaction, bool isIncome) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.reason,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(AppColors.TEXTPRIMARY),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(transaction.date),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(AppColors.TEXTSECONDARY),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            _formatCurrency(
              transaction.amount,
              showSign: true,
              isExpense: !isIncome,
            ),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniBadge({
    required String title,
    required String amountText,
    required Color color,
    required Color bgColor,
    required IconData icon,
    required bool isPhone,
    double? widthPercent,
  }) {
    double? w;
    if (isPhone && widthPercent != null) {
        if (widthPercent == 1.0) {
            w = double.infinity;
        } else {
            w = (MediaQuery.of(Get.context!).size.width * widthPercent) - 34;
        }
    }
    return Container(
      width: w,
      padding: EdgeInsets.symmetric(horizontal: isPhone ? 12 : 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(AppColors.TEXTSECONDARY),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  amountText,
                  style: TextStyle(
                    fontSize: isPhone ? 13 : 15,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 32,
            color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.4),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 12,
              color: Color(AppColors.TEXTSECONDARY),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
