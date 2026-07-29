import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
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

  void _showMonthDetailsPopup(BuildContext context, MonthlyReportItem item) {
    showDialog(
      context: context,
      builder: (context) => _MonthDetailsDialog(
        item: item,
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
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
                              amountText: _formatCurrency(controller.ytdTotalIncome, showSign: true, isExpense: false),
                              icon: Icons.trending_up,
                              color: const Color(0xFF10B981),
                              bgColor: const Color(0xFFECFDF5),
                            ),
                            const SizedBox(width: 12),
                            _buildSummaryCard(
                              title: 'YTD Expense',
                              amountText: _formatCurrency(controller.ytdTotalExpense, showSign: true, isExpense: true),
                              icon: Icons.trending_down,
                              color: const Color(0xFFEF4444),
                              bgColor: const Color(0xFFFEF2F2),
                            ),
                            const SizedBox(width: 12),
                            _buildSummaryCard(
                              title: 'YTD Net Profit',
                              amountText: _formatCurrency(controller.ytdNetProfit, showSign: false),
                              icon: Icons.auto_graph_rounded,
                              color: const Color(AppColors.PRIMARY),
                              bgColor: const Color(0xFFEFF6FF),
                            ),
                          ],
                        );
                      }),
                    ],
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
                                        color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.analytics_outlined, color: Color(AppColors.PRIMARY), size: 20),
                                    ),
                                    const SizedBox(width: 14),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Obx(() {
                                          return Text(
                                            '${controller.selectedReportYear.value} Monthly Financial Performance',
                                            style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              color: const Color(AppColors.TEXTPRIMARY),
                                            ),
                                          );
                                        }),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Click "View" on any month to inspect all income and expense entries',
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: const Color(AppColors.TEXTSECONDARY),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Obx(() {
                                    final count = controller.annualReportList.length;
                                    final yr = controller.selectedReportYear.value;
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
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            color: const Color(0xFFF8FAFC),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  child: Text('No.', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Text('Month', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text('Income (₹)  •  MoM Change', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text('Expense (₹)  •  MoM Change', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text('Net Profit (₹)  •  MoM Growth', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text('Status', textAlign: TextAlign.center, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                ),
                                SizedBox(
                                  width: 90,
                                  child: Text('Action', textAlign: TextAlign.center, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                ),
                              ],
                            ),
                          ),

                          // Table Rows
                          Expanded(
                            child: Obx(() {
                              if (controller.annualReportList.isEmpty) {
                                return const Center(
                                  child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
                                );
                              }

                              return ListView.separated(
                                itemCount: controller.annualReportList.length,
                                separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                                itemBuilder: (context, index) {
                                  final item = controller.annualReportList[index];
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
                'Annual Accounts & Profit Report',
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

              // Year Selector Dropdown Pill
              Obx(() {
                final years = controller.availableYears;
                final currentSel = controller.selectedReportYear.value;

                return Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(AppColors.PRIMARY).withValues(alpha: 0.3)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: years.contains(currentSel) ? currentSel : (years.isNotEmpty ? years.first : currentSel),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(AppColors.PRIMARY)),
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
                            children: [
                              const Icon(Icons.calendar_today_outlined, size: 14, color: Color(AppColors.PRIMARY)),
                              const SizedBox(width: 8),
                              Text('$year', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
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
      color: isCurrent ? const Color(0xFFEFF6FF).withValues(alpha: 0.5) : Colors.transparent,
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
                color: isCurrent ? const Color(AppColors.PRIMARY) : const Color(0xFF94A3B8),
              ),
            ),
          ),

          // Month Name
          SizedBox(
            width: 140,
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
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(AppColors.PRIMARY),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'NOW',
                      style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Income & MoM Change
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  _formatCurrency(item.income, showSign: false),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 10),
                _buildChangeBadge(item.incomeChange, isExpense: false),
              ],
            ),
          ),

          // Expense & MoM Change
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  _formatCurrency(item.expense, showSign: false),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(width: 10),
                _buildChangeBadge(item.expenseChange, isExpense: true),
              ],
            ),
          ),

          // Net Profit & MoM Growth
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Text(
                  _formatCurrency(item.netProfit, showSign: false),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: item.netProfit >= 0 ? const Color(AppColors.PRIMARY) : const Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(width: 10),
                _buildChangeBadge(item.profitChange, isExpense: false),
              ],
            ),
          ),

          // Status / Profitability Badge
          SizedBox(
            width: 120,
            child: Center(
              child: _buildStatusTag(item.income, item.expense, isFutureMonth: item.isFutureMonth),
            ),
          ),

          // Action / View Button
          SizedBox(
            width: 90,
            child: Center(
              child: InkWell(
                onTap: () => _showMonthDetailsPopup(context, item),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(AppColors.PRIMARY).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(AppColors.PRIMARY).withValues(alpha: 0.2)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.visibility_outlined, size: 14, color: Color(AppColors.PRIMARY)),
                      SizedBox(width: 4),
                      Text(
                        'View',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(AppColors.PRIMARY),
                        ),
                      ),
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

  Widget _buildChangeBadge(PercentageResult res, {required bool isExpense}) {
    if (res.isFuture) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '—',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.5),
          ),
        ),
      );
    }

    if (res.isZero) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '0.0%',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.8),
          ),
        ),
      );
    }

    final bool isPositiveTrend = isExpense ? !res.isIncrease : res.isIncrease;
    final Color bgColor = isPositiveTrend ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2);
    final Color textColor = isPositiveTrend ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final IconData arrowIcon = res.isIncrease ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(arrowIcon, size: 11, color: textColor),
          const SizedBox(width: 3),
          Text(
            res.text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(int income, int expense, {required bool isFutureMonth}) {
    if (isFutureMonth) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Upcoming ⏳',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.6),
          ),
        ),
      );
    }

    if (income == 0 && expense == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'No Activity ⚪',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(AppColors.TEXTSECONDARY),
          ),
        ),
      );
    }

    final int net = income - expense;
    if (net > 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFECFDF5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Profitable 🟢',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFF10B981),
          ),
        ),
      );
    } else if (net < 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Loss 🔴',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFFEF4444),
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Break Even ⚪',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(AppColors.PRIMARY),
          ),
        ),
      );
    }
  }
}

class _MonthDetailsDialog extends StatelessWidget {
  final MonthlyReportItem item;
  final AccountsController controller;

  const _MonthDetailsDialog({
    required this.item,
    required this.controller,
  });

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
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

  @override
  Widget build(BuildContext context) {
    final incomes = controller.getIncomesForMonth(item.year, item.monthNumber);
    final expenses = controller.getExpensesForMonth(item.year, item.monthNumber);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 950,
        height: 680,
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
            // Top Modal Header Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.calendar_month_rounded, color: Color(AppColors.PRIMARY), size: 24),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item.monthName} • Transaction Breakdown',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(AppColors.TEXTPRIMARY),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Complete chronological logs of all income and expense entries for this month',
                            style: TextStyle(
                              fontSize: 13,
                              color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Close button
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close_rounded, color: Color(AppColors.TEXTSECONDARY), size: 24),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),

            // Summary Badges Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              color: const Color(0xFFF8FAFC),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMiniBadge(
                    title: 'Total Income (${incomes.length})',
                    amountText: _formatCurrency(item.income, showSign: true, isExpense: false),
                    color: const Color(0xFF10B981),
                    bgColor: const Color(0xFFECFDF5),
                    icon: Icons.trending_up,
                  ),
                  _buildMiniBadge(
                    title: 'Total Expense (${expenses.length})',
                    amountText: _formatCurrency(item.expense, showSign: true, isExpense: true),
                    color: const Color(0xFFEF4444),
                    bgColor: const Color(0xFFFEF2F2),
                    icon: Icons.trending_down,
                  ),
                  _buildMiniBadge(
                    title: 'Net Profit / Loss',
                    amountText: _formatCurrency(item.netProfit, showSign: false),
                    color: item.netProfit >= 0 ? const Color(AppColors.PRIMARY) : const Color(0xFFEF4444),
                    bgColor: const Color(0xFFEFF6FF),
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                ],
              ),
            ),

            // Side-by-side Complete Income & Expense Lists
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    // LEFT SIDE: INCOME LIST
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(AppColors.WHITE),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                              decoration: const BoxDecoration(
                                color: Color(0xFFECFDF5),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.arrow_downward_rounded, color: Color(0xFF10B981), size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Income Transactions (${incomes.length})',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF065F46),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _formatCurrency(item.income, showSign: false),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF10B981),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: incomes.isEmpty
                                  ? _buildEmptyState('No income transactions recorded for ${item.monthName}')
                                  : ListView.separated(
                                      padding: const EdgeInsets.all(12),
                                      itemCount: incomes.length,
                                      separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                                      itemBuilder: (context, idx) {
                                        final inc = incomes[idx];
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
                                                      inc.reason,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w700,
                                                        color: Color(AppColors.TEXTPRIMARY),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      _formatDate(inc.date),
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Color(AppColors.TEXTSECONDARY),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _formatCurrency(inc.amount, showSign: true, isExpense: false),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0xFF10B981),
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
                    ),
                    const SizedBox(width: 20),

                    // RIGHT SIDE: EXPENSE LIST
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(AppColors.WHITE),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFEF2F2),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.arrow_upward_rounded, color: Color(0xFFEF4444), size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Expense Transactions (${expenses.length})',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF991B1B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _formatCurrency(item.expense, showSign: false),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFFEF4444),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: expenses.isEmpty
                                  ? _buildEmptyState('No expense transactions recorded for ${item.monthName}')
                                  : ListView.separated(
                                      padding: const EdgeInsets.all(12),
                                      itemCount: expenses.length,
                                      separatorBuilder: (_, _) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                                      itemBuilder: (context, idx) {
                                        final exp = expenses[idx];
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
                                                      exp.reason,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w700,
                                                        color: Color(AppColors.TEXTPRIMARY),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      _formatDate(exp.date),
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Color(AppColors.TEXTSECONDARY),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                _formatCurrency(exp.amount, showSign: true, isExpense: true),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0xFFEF4444),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniBadge({
    required String title,
    required String amountText,
    required Color color,
    required Color bgColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(AppColors.TEXTSECONDARY))),
              const SizedBox(height: 2),
              Text(amountText, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: color)),
            ],
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
          Icon(Icons.inbox_outlined, size: 40, color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.4)),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
