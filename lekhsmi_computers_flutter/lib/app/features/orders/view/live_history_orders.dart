import 'package:flutter/material.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import 'package:lekhsmi_computers_flutter/core/utils/responsive_utils.dart';
import 'package:lekhsmi_computers_flutter/app/features/orders/controller/orders_controller.dart';
import 'live_history_orders_mobile_view.dart';

class LiveHistoryOrdersView extends StatefulWidget {
  const LiveHistoryOrdersView({super.key});

  @override
  State<LiveHistoryOrdersView> createState() => _LiveHistoryOrdersViewState();
}

class _LiveHistoryOrdersViewState extends State<LiveHistoryOrdersView> {
  final OrdersController controller = Get.put(OrdersController());

  void _showOrderHistoryPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _OrderHistoryPopupDialog(
          controller: controller,
          formatDate: _formatDate,
          formatCurrency: _formatCurrency,
          buildOrderCard: (ctx, item, isHist) => _buildOrderCard(ctx, item, isHistory: isHist),
        );
      },
    );
  }

  String _formatDate(DateTime d) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    final day = d.day.toString().padLeft(2, '0');
    final mon = months[d.month - 1];
    return '$mon $day, ${d.year}';
  }

  String _formatCurrency(int amount) {
    final isNegative = amount < 0;
    final absVal = amount.abs();
    final s = absVal.toString();
    if (s.length <= 3) {
      return isNegative ? '-₹$s' : '₹$s';
    }
    String result = s.substring(s.length - 3);
    int i = s.length - 3;
    while (i > 0) {
      final end = i;
      final start = (i - 2) < 0 ? 0 : i - 2;
      result = '${s.substring(start, end)},$result';
      i -= 2;
    }
    return isNegative ? '-₹$result' : '₹$result';
  }

  void _showEditOrderModal(BuildContext context, OrderHistory item) {
    showDialog(
      context: context,
      builder: (context) {
        return _EditOrderDialog(
          item: item,
          controller: controller,
          formatDate: _formatDate,
        );
      },
    );
  }

  void _showEditMoneyModal(BuildContext context, OrderHistory item) {
    final amountCtrl = TextEditingController(text: item.amount.toString());
    showDialog(
      context: context,
      builder: (context) {
        final isPhone = ResponsiveUtils.isPhone(context);
        final maxH = MediaQuery.of(context).size.height * 0.85;
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: isPhone ? 14 : 32, vertical: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 440,
              maxHeight: maxH,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(AppColors.WHITE),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.currency_rupee, color: Color(0xFF10B981), size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Update Order Amount',
                                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(AppColors.TEXTPRIMARY)),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Order ID: #${item.order.orderId}',
                                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY)),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Color(AppColors.TEXTSECONDARY)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Price (₹)',
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(AppColors.TEXTPRIMARY)),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: amountCtrl,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY)),
                      decoration: InputDecoration(
                        hintText: 'Enter new price',
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFCBD5E1))),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(AppColors.PRIMARY), width: 1.5)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY))),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            final newAmount = int.tryParse(amountCtrl.text.trim()) ?? item.amount;
                            await controller.updateOrderAmount(item, newAmount);
                            if (context.mounted) Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(AppColors.PRIMARY),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text('Save Price', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isPhone(context)) {
      return LiveHistoryOrdersMobileView(
        controller: controller,
        buildTitleSection: _buildTitleSection,
        onShowOrderHistoryPopup: _showOrderHistoryPopup,
        buildOrderCard: (ctx, item, {required isHistory}) => _buildOrderCard(ctx, item, isHistory: isHistory),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: Column(
                  children: [
                    // Top Sub-Header Bar Inside Card
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Active Live Orders',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(AppColors.TEXTPRIMARY),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Obx(() {
                                final count = controller.displayedOrders.length;
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '$count ACTIVE',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(AppColors.PRIMARY),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                          Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              SizedBox(
                                width: 260,
                                height: 48,
                                child: TextField(
                                  onChanged: (val) => controller.searchQuery.value = val,
                                  style: GoogleFonts.inter(fontSize: 13.5, color: const Color(AppColors.TEXTPRIMARY)),
                                  decoration: InputDecoration(
                                    hintText: 'Search live orders...',
                                    hintStyle: GoogleFonts.inter(
                                      color: const Color(AppColors.HINTTEXT),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                    prefixIcon: const Icon(Icons.search, size: 18, color: Color(AppColors.TEXTSECONDARY)),
                                    filled: true,
                                    fillColor: const Color(0xFFF8FAFC),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 48,
                                child: TextButton.icon(
                                  onPressed: () => _showOrderHistoryPopup(context),
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(AppColors.PRIMARY),
                                    padding: const EdgeInsets.symmetric(horizontal: 18),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.history,
                                    size: 18,
                                    color: Color(AppColors.PRIMARY),
                                  ),
                                  label: Text(
                                    'Order History',
                                    style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),

                    // Live Orders Cards List
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
                          );
                        }

                        final list = controller.displayedOrders;
                        if (list.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 54,
                                  color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.4),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No active live orders',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(AppColors.TEXTSECONDARY),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                          itemCount: list.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 20),
                          itemBuilder: (context, idx) {
                            final item = list[idx];
                            return _buildOrderCard(context, item, isHistory: false);
                          },
                        );
                      }),
                    ),
                  ],
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
                'Live Service & Repair Orders',
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
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'REAL-TIME STATUS',
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
          Wrap(
            spacing: 8,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => controller.fetchOrders(),
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

  Widget _buildOrderCard(BuildContext context, OrderHistory item, {required bool isHistory}) {
    final order = item.order;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.receipt_long_rounded, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.orderId,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.event_note_rounded, size: 14, color: Color(0xFF64748B)),
                            const SizedBox(width: 6),
                            Text(
                              _formatDate(order.date),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                _buildStatusSelector(item, isHistory),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Customer Details Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.customerName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildEliteContactTag(Icons.phone_rounded, '+91 ${order.contact1}', const Color(0xFF0284C7)),
                    if (order.contact2 != null && order.contact2! > 0)
                      _buildEliteContactTag(Icons.phone_android_rounded, '+91 ${order.contact2}', const Color(0xFF0284C7)),
                    if (order.email != null && order.email!.isNotEmpty)
                      _buildEliteContactTag(Icons.alternate_email_rounded, order.email!, const Color(0xFF10B981)),
                    _buildEliteContactTag(Icons.location_on_rounded, order.address, const Color(0xFFF59E0B)),
                  ],
                ),
              ],
            ),
          ),

          // Complaints Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              border: Border.symmetric(horizontal: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.build_circle_rounded, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 8),
                    Text(
                      'COMPLAINTS / REQUIREMENTS',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...order.complaints.asMap().entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE2E8F0),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${e.key + 1}',
                            style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: const Color(0xFF475569)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            e.value,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF334155),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          // Footer: Price & Actions
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ESTIMATED PRICE',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF94A3B8),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatCurrency(item.amount),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        if (!isHistory) ...[
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => _showEditMoneyModal(context, item),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.edit_rounded, size: 14, color: Color(0xFF64748B)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                if (!isHistory)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildEliteActionButton(
                        icon: Icons.edit_rounded,
                        label: 'Edit',
                        color: const Color(0xFF0F172A),
                        onTap: () => _showEditOrderModal(context, item),
                      ),
                      _buildEliteActionButton(
                        icon: Icons.close_rounded,
                        label: 'Cancel',
                        color: const Color(0xFFEF4444),
                        onTap: () => controller.updateOrderStatus(item, 'Cancelled'),
                      ),
                      _buildEliteActionButton(
                        icon: Icons.check_circle_rounded,
                        label: 'Complete',
                        color: const Color(0xFF10B981),
                        isPrimary: true,
                        onTap: () => controller.updateOrderStatus(item, 'Completed'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEliteContactTag(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEliteActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isPrimary ? color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isPrimary ? color : const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isPrimary ? Colors.white : color),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isPrimary ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSelector(OrderHistory item, bool isHistory) {
    Color borderColor;
    Color bgColor;
    Color textColor;

    switch (item.status) {
      case 'Ongoing':
        borderColor = const Color(0xFF3B82F6);
        bgColor = const Color(0xFFEFF6FF);
        textColor = const Color(0xFF2563EB);
        break;
      case 'Pending':
        borderColor = const Color(0xFFF59E0B);
        bgColor = const Color(0xFFFFFBEB);
        textColor = const Color(0xFFD97706);
        break;
      case 'Completed':
        borderColor = const Color(0xFF10B981);
        bgColor = const Color(0xFFECFDF5);
        textColor = const Color(0xFF059669);
        break;
      case 'Cancelled':
      default:
        borderColor = const Color(0xFFEF4444);
        bgColor = const Color(0xFFFEF2F2);
        textColor = const Color(0xFFDC2626);
        break;
    }

    if (isHistory) {
      // Static badge in history mode
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 6, height: 6, decoration: BoxDecoration(color: textColor, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(
              item.status,
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: textColor),
            ),
          ],
        ),
      );
    }

    // Interactive Dropdown in Live mode ('Ongoing' vs 'Pending')
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: ['Ongoing', 'Pending'].contains(item.status) ? item.status : 'Pending',
          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: textColor),
          isDense: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(14),
          elevation: 12,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: textColor),
          items: [
            DropdownMenuItem(
              value: 'Ongoing',
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  const Icon(Icons.circle, size: 6, color: Color(0xFF2563EB)),
                  const SizedBox(width: 8),
                  Text('Ongoing', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF2563EB))),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 'Pending',
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  const Icon(Icons.circle, size: 6, color: Color(0xFFD97706)),
                  const SizedBox(width: 8),
                  Text('Pending', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFFD97706))),
                ],
              ),
            ),
          ],
          onChanged: (newStatus) {
            if (newStatus != null && newStatus != item.status) {
              controller.updateOrderStatus(item, newStatus);
            }
          },
        ),
      ),
    );
  }
}

class _OrderHistoryPopupDialog extends StatefulWidget {
  final OrdersController controller;
  final String Function(DateTime) formatDate;
  final String Function(int) formatCurrency;
  final Widget Function(BuildContext, OrderHistory, bool) buildOrderCard;

  const _OrderHistoryPopupDialog({
    required this.controller,
    required this.formatDate,
    required this.formatCurrency,
    required this.buildOrderCard,
  });

  @override
  State<_OrderHistoryPopupDialog> createState() => _OrderHistoryPopupDialogState();
}

class _OrderHistoryPopupDialogState extends State<_OrderHistoryPopupDialog> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: ResponsiveUtils.isPhone(context)
          ? const EdgeInsets.all(12)
          : const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Container(
        width: 960,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.95,
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        padding: ResponsiveUtils.isPhone(context)
            ? const EdgeInsets.all(16)
            : const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(AppColors.WHITE),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Popup Header Row 1: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 6,
                    children: [
                      Text(
                        'Order History',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: const Color(AppColors.TEXTPRIMARY),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF64748B),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        'Completed & Cancelled Orders',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Color(AppColors.TEXTPRIMARY)),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Popup Header Row 2: Filter & Search Bar
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: [
                    // Year filter dropdown
                    Obx(() {
                      final years = widget.controller.availableHistoryYears;
                      final selectedY = widget.controller.selectedHistoryYear.value ?? DateTime.now().year;
                      final validY = years.contains(selectedY) ? selectedY : years.first;
                      return Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: validY,
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(AppColors.TEXTSECONDARY)),
                            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY)),
                            onChanged: (val) {
                              if (val != null) {
                                widget.controller.selectedHistoryYear.value = val;
                              }
                            },
                            items: [
                              for (final y in years)
                                DropdownMenuItem<int>(
                                  value: y,
                                  child: Text(y.toString(), style: GoogleFonts.inter(fontSize: 13)),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                    // Month filter dropdown
                    Obx(() {
                      final selectedM = widget.controller.selectedHistoryMonth.value;
                      const months = [
                        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                      ];
                      return Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int?>(
                            value: selectedM,
                            icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(AppColors.TEXTSECONDARY)),
                            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY)),
                            onChanged: (val) {
                              widget.controller.selectedHistoryMonth.value = val;
                            },
                            items: [
                              DropdownMenuItem<int?>(
                                value: null,
                                child: Text('All Months', style: GoogleFonts.inter(fontSize: 13)),
                              ),
                              for (int i = 1; i <= 12; i++)
                                DropdownMenuItem<int?>(
                                  value: i,
                                  child: Text(months[i - 1], style: GoogleFonts.inter(fontSize: 13)),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                // Search box in dialog
                SizedBox(
                  width: 260,
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        _query = val;
                      });
                    },
                    style: GoogleFonts.inter(fontSize: 13.5, color: const Color(AppColors.TEXTPRIMARY)),
                    decoration: InputDecoration(
                      hintText: 'Search history...',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(AppColors.HINTTEXT),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                      prefixIcon: const Icon(Icons.search, size: 18, color: Color(AppColors.TEXTSECONDARY)),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Dialog Body List
            Expanded(
              child: Obx(() {
                final list = widget.controller.getFilteredHistoryOrders(_query);
                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_toggle_off,
                          size: 54,
                          color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No completed or cancelled orders found',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 20),
                  itemBuilder: (context, idx) {
                    final item = list[idx];
                    return widget.buildOrderCard(context, item, true);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditOrderDialog extends StatefulWidget {
  final OrderHistory item;
  final OrdersController controller;
  final String Function(DateTime) formatDate;

  const _EditOrderDialog({
    required this.item,
    required this.controller,
    required this.formatDate,
  });

  @override
  State<_EditOrderDialog> createState() => _EditOrderDialogState();
}

class _EditOrderDialogState extends State<_EditOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phone1Ctrl;
  late final TextEditingController _phone2Ctrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _amountCtrl;
  late DateTime _selectedDate;
  final List<TextEditingController> _complaintControllers = [];

  @override
  void initState() {
    super.initState();
    final o = widget.item.order;
    _nameCtrl = TextEditingController(text: o.customerName);
    _phone1Ctrl = TextEditingController(text: o.contact1.toString());
    _phone2Ctrl = TextEditingController(text: o.contact2 != null ? o.contact2.toString() : '');
    _emailCtrl = TextEditingController(text: o.email ?? '');
    _addressCtrl = TextEditingController(text: o.address);
    _amountCtrl = TextEditingController(text: widget.item.amount > 0 ? widget.item.amount.toString() : '');
    _selectedDate = o.date;

    for (final c in o.complaints) {
      _complaintControllers.add(TextEditingController(text: c));
    }
    if (_complaintControllers.isEmpty) {
      _complaintControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phone1Ctrl.dispose();
    _phone2Ctrl.dispose();
    _emailCtrl.dispose();
    _addressCtrl.dispose();
    _amountCtrl.dispose();
    for (final c in _complaintControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addComplaint() {
    setState(() {
      _complaintControllers.add(TextEditingController());
    });
  }

  void _removeComplaint(int index) {
    if (_complaintControllers.length <= 1) return;
    setState(() {
      final removed = _complaintControllers.removeAt(index);
      removed.dispose();
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

  Widget _buildResponsiveRow({
    required bool isPhone,
    required Widget first,
    required Widget second,
    int flex1 = 1,
    int flex2 = 1,
  }) {
    if (isPhone) {
      return Column(
        children: [
          first,
          const SizedBox(height: 14),
          second,
        ],
      );
    }
    return Row(
      children: [
        Expanded(flex: flex1, child: first),
        const SizedBox(width: 16),
        Expanded(flex: flex2, child: second),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = ResponsiveUtils.isPhone(context);
    final maxH = MediaQuery.of(context).size.height * 0.88;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isPhone ? 14 : 32, vertical: 16),
      child: Container(
        width: 680,
        constraints: BoxConstraints(maxHeight: maxH),
        padding: EdgeInsets.all(isPhone ? 20 : 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Order Details',
                          style: GoogleFonts.inter(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: const Color(AppColors.TEXTPRIMARY),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Update customer information or complaints for ${widget.item.order.orderId}',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Color(AppColors.TEXTSECONDARY)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      _buildResponsiveRow(
                        isPhone: isPhone,
                        first: _buildInput(
                          controller: _nameCtrl,
                          label: 'Customer Name',
                          icon: Icons.person_outline,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                        second: _buildInput(
                          controller: _phone1Ctrl,
                          label: 'Phone Number (Primary)',
                          icon: Icons.phone_outlined,
                          isPhone: true,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildResponsiveRow(
                        isPhone: isPhone,
                        first: _buildInput(
                          controller: _phone2Ctrl,
                          label: 'Phone Number (Alt / Optional)',
                          icon: Icons.phone_outlined,
                          isPhone: true,
                        ),
                        second: _buildInput(
                          controller: _emailCtrl,
                          label: 'Email (Optional)',
                          icon: Icons.email_outlined,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildResponsiveRow(
                        isPhone: isPhone,
                        first: _buildInput(
                          controller: _addressCtrl,
                          label: 'Address',
                          icon: Icons.location_on_outlined,
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                        ),
                        second: _buildInput(
                          controller: _amountCtrl,
                          label: 'Price (₹)',
                          icon: Icons.currency_rupee,
                          isNumber: true,
                        ),
                        flex1: 2,
                        flex2: 1,
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _pickDate(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFCBD5E1)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_today_outlined, size: 18, color: Color(AppColors.PRIMARY)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Order Date: ${widget.formatDate(_selectedDate)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(AppColors.TEXTPRIMARY),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.edit_calendar_outlined, size: 18, color: Color(AppColors.TEXTSECONDARY)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Complaints / Services Requested',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: const Color(AppColors.TEXTPRIMARY),
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _addComplaint,
                            icon: const Icon(Icons.add, size: 16),
                            label: Text('Add Row', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(_complaintControllers.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _complaintControllers[index],
                                  decoration: InputDecoration(
                                    labelText: 'Complaint #${index + 1}',
                                    prefixIcon: const Icon(Icons.build_outlined, size: 18),
                                    filled: true,
                                    fillColor: const Color(0xFFF8FAFC),
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
                              if (_complaintControllers.length > 1) ...[
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () => _removeComplaint(index),
                                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                                ),
                              ],
                            ],
                          ),
                        );
                      }),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY))),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() != true) return;
                      final name = _nameCtrl.text.trim();
                      final phone1 = int.tryParse(_phone1Ctrl.text.trim()) ?? 0;
                      final phone2 = int.tryParse(_phone2Ctrl.text.trim());
                      final email = _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim();
                      final address = _addressCtrl.text.trim();
                      final amount = int.tryParse(_amountCtrl.text.trim()) ?? 0;
                      final complaints = _complaintControllers
                          .map((c) => c.text.trim())
                          .where((t) => t.isNotEmpty)
                          .toList();
                      if (complaints.isEmpty) {
                        AppNotification.warning('Validation', 'Please enter at least one complaint / service.');
                        return;
                      }

                      final success = await widget.controller.updateExistingOrderDetails(
                        historyItem: widget.item,
                        customerName: name,
                        contact1: phone1,
                        contact2: phone2,
                        email: email,
                        address: address,
                        date: _selectedDate,
                        complaints: complaints,
                        amount: amount,
                      );
                      if (success && context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(AppColors.PRIMARY),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Save Changes', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isNumber = false,
    bool isPhone = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : (isNumber ? TextInputType.number : TextInputType.text),
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: const Color(AppColors.TEXTSECONDARY)),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
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
    );
  }
}
