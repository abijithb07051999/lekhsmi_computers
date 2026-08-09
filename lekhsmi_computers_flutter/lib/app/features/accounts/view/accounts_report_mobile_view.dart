import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import '../controller/accounts_controller.dart';
import 'accounts_report_view.dart';

class AccountsReportMobileView extends StatelessWidget {
  const AccountsReportMobileView({super.key});

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

  void _showMonthDetailsPopup(
    BuildContext context,
    MonthlyReportItem item,
    AccountsController controller,
  ) {
    showDialog(
      context: context,
      builder:
          (context) =>
              MonthDetailsDialog(item: item, controller: controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountsController>();
    return Column(
      children: [
        // Compact Phone Header with Year Dropdown
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8,
            children: [
              Text(
                'Financial Report',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(AppColors.TEXTPRIMARY),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    final years = controller.availableYears;
                    final currentSel = controller.selectedReportYear.value;
                    return Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(
                          AppColors.PRIMARY,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(
                            AppColors.PRIMARY,
                          ).withValues(alpha: 0.3),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value:
                              years.contains(currentSel)
                                  ? currentSel
                                  : (years.isNotEmpty
                                      ? years.first
                                      : currentSel),
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: Color(AppColors.PRIMARY),
                          ),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(AppColors.PRIMARY),
                          ),
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 12,
                          onChanged: (val) {
                            if (val != null) {
                              controller.changeReportYear(val);
                            }
                          },
                          items:
                              years.map((year) {
                                return DropdownMenuItem<int>(
                                  value: year,
                                  child: Text('$year'),
                                );
                              }).toList(),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Color(AppColors.PRIMARY),
                      size: 20,
                    ),
                    onPressed: () => controller.fetchAnnualReport(),
                    tooltip: 'Refresh',
                  ),
                ],
              ),
            ],
          ),
        ),
        // YTD Summary Cards & Report List
        Expanded(
          child: Column(
            children: [
              // YTD Summary Cards
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 16, 14, 0),
                child: Obx(() {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildPhoneSummaryCard(
                              title: 'YTD Income',
                              amountText: _formatCurrency(
                                controller.ytdTotalIncome,
                                showSign: true,
                                isExpense: false,
                              ),
                              color: const Color(0xFF10B981),
                              icon: Icons.arrow_downward_rounded,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildPhoneSummaryCard(
                              title: 'YTD Expense',
                              amountText: _formatCurrency(
                                controller.ytdTotalExpense,
                                showSign: true,
                                isExpense: true,
                              ),
                              color: const Color(0xFFEF4444),
                              icon: Icons.arrow_upward_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildPhoneSummaryCard(
                        title: 'YTD Net Profit',
                        amountText: _formatCurrency(
                          controller.ytdNetProfit,
                          showSign: true,
                          isExpense: false,
                        ),
                        color: controller.ytdNetProfit >= 0
                            ? const Color(AppColors.PRIMARY)
                            : const Color(0xFFEF4444),
                        icon: Icons.account_balance_wallet_rounded,
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Months List
              Expanded(
                child: _buildMobileReportList(context, controller),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneSummaryCard({
    required String title,
    required String amountText,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(AppColors.TEXTSECONDARY),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  amountText,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(AppColors.TEXTPRIMARY),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileReportList(
    BuildContext context,
    AccountsController controller,
  ) {
    return Obx(() {
      if (controller.annualReportList.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
        );
      }
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        itemCount: controller.annualReportList.length,
        itemBuilder: (context, index) {
          final item = controller.annualReportList[index];
          final bool isCurrent = item.isCurrentMonth;
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isCurrent
                    ? const Color(AppColors.PRIMARY).withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
              boxShadow: [
                BoxShadow(
                  color: isCurrent 
                      ? const Color(AppColors.PRIMARY).withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.03),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 8,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '#${item.monthNumber}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color:
                                isCurrent
                                    ? const Color(AppColors.PRIMARY)
                                    : const Color(0xFF94A3B8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.monthName,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
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
                    _buildStatusTag(
                      item.income,
                      item.expense,
                      isFutureMonth: item.isFutureMonth,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  spacing: 12,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Income',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: const Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatCurrency(item.income, showSign: false),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF10B981),
                              ),
                            ),
                            const SizedBox(width: 4),
                            _buildChangeBadge(
                              item.incomeChange,
                              isExpense: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expense',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: const Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatCurrency(item.expense, showSign: false),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFFEF4444),
                              ),
                            ),
                            const SizedBox(width: 4),
                            _buildChangeBadge(
                              item.expenseChange,
                              isExpense: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Net Profit',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: const Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatCurrency(item.netProfit, showSign: false),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color:
                                    item.netProfit >= 0
                                        ? const Color(AppColors.PRIMARY)
                                        : const Color(0xFFEF4444),
                              ),
                            ),
                            const SizedBox(width: 4),
                            _buildChangeBadge(
                              item.profitChange,
                              isExpense: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap:
                        () => _showMonthDetailsPopup(
                          context,
                          item,
                          controller,
                        ),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.visibility_outlined,
                            size: 14,
                            color: Color(AppColors.PRIMARY),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'View Details',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(AppColors.PRIMARY),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
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
    final Color bgColor =
        isPositiveTrend
            ? const Color(0xFFECFDF5)
            : const Color(0xFFFEF2F2);
    final Color textColor =
        isPositiveTrend
            ? const Color(0xFF10B981)
            : const Color(0xFFEF4444);
    final IconData arrowIcon =
        res.isIncrease
            ? Icons.arrow_upward_rounded
            : Icons.arrow_downward_rounded;

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

  Widget _buildStatusTag(
    int income,
    int expense, {
    required bool isFutureMonth,
  }) {
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
