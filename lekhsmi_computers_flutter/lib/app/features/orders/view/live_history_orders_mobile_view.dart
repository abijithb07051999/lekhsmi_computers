import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/app/features/orders/controller/orders_controller.dart';

class LiveHistoryOrdersMobileView extends StatelessWidget {
  final OrdersController controller;
  final Widget Function() buildTitleSection;
  final void Function(BuildContext) onShowOrderHistoryPopup;
  final Widget Function(BuildContext, OrderHistory, {required bool isHistory}) buildOrderCard;

  const LiveHistoryOrdersMobileView({
    super.key,
    required this.controller,
    required this.buildTitleSection,
    required this.onShowOrderHistoryPopup,
    required this.buildOrderCard,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CRITICAL FIX: Allow keyboard to scroll the view!
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // If buildTitleSection is just an old header, we can still use it, 
          // or we can just rely on our elite container below as the primary interface.
          buildTitleSection(),
          Expanded(
            child: Container(
              color: const Color(0xFFF8FAFC),
              child: Column(
                children: [
                  // ── ELITE SEARCH & ACTION AREA ───────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: const Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Active Live Orders',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                                letterSpacing: -0.5,
                              ),
                            ),
                            Obx(() {
                              final count = controller.displayedOrders.length;
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF10B981),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '$count ACTIVE',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF059669),
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildEliteSearchBar(
                          hintText: 'Search live orders...',
                          onChanged: (val) => controller.searchQuery.value = val,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () => onShowOrderHistoryPopup(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF0F172A),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            icon: const Icon(Icons.history_rounded, size: 18, color: Color(0xFF64748B)),
                            label: Text(
                              'View Order History Archive',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700, 
                                fontSize: 13.5,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── ELITE LIVE ORDERS LIST ──────────────────────────────────────────
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
                        );
                      }
                      final list = controller.displayedOrders;
                      if (list.isEmpty) {
                        return _buildEliteEmptyState();
                      }
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: list.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 16),
                        itemBuilder: (context, idx) {
                          final item = list[idx];
                          // Utilizing the provided buildOrderCard, assuming it looks okay.
                          return buildOrderCard(context, item, isHistory: false);
                        },
                      );
                    }),
                  ),
                ],
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
  Widget _buildEliteSearchBar({
    required String hintText,
    required Function(String) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        onChanged: onChanged,
        style: GoogleFonts.inter(
          fontSize: 14.5,
          color: const Color(0xFF0F172A),
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF94A3B8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(
              Icons.search_rounded,
              color: Color(0xFF64748B),
              size: 22,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildEliteEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.inbox_rounded,
                size: 48,
                color: Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No Active Live Orders',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'All devices have been processed or no orders have been registered yet.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
