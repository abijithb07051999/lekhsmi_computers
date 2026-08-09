import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';

class DashboardMobileView extends StatelessWidget {
  final String selectedMenu;
  final void Function(String title, {bool resetTab}) onMenuSelected;
  final void Function(String title, {int tabIndex}) navigateToMenu;
  final int brandSupplierTabIndex;
  final Widget Function() buildMainContent;

  const DashboardMobileView({
    super.key,
    required this.selectedMenu,
    required this.onMenuSelected,
    required this.navigateToMenu,
    required this.brandSupplierTabIndex,
    required this.buildMainContent,
  });

  @override
  Widget build(BuildContext context) {
    return _buildMobileDashboardScaffold(context);
  }

  Widget _buildMobileDashboardScaffold(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(AppColors.BACKGROUND),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFE2E8F0),
            height: 1,
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                'assets/logo/lexmi_computers_logo.png',
                width: 24,
                height: 24,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.computer_rounded,
                  color: Color(AppColors.PRIMARY),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LEKHSMI ENTERPRISE',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'SaaS Management Portal',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'LIVE',
                    style: GoogleFonts.inter(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF059669),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: _buildEliteDrawer(context),
      body: buildMainContent(),
    );
  }

  // ===========================================================================
  // ELITE EXECUTIVE DRAWER FOR MOBILE
  // ===========================================================================
  Widget _buildEliteDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Logo & Workspace Brand Header
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 18),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/logo/lexmi_computers_logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(AppColors.PRIMARY),
                          child: Center(
                            child: Text(
                              'LC',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(AppColors.PRIMARY),
                              Color(AppColors.SECONDAY),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Obx(() {
                            return Text(
                              Get.find<SettingsController>().storeName.value,
                              style: GoogleFonts.inter(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              AppColors.PRIMARY,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'ENTERPRISE ERP',
                            style: GoogleFonts.inter(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(AppColors.PRIMARY),
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Navigation
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      bottom: 8,
                      top: 4,
                    ),
                    child: Text(
                      'MAIN MENU',
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.7),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  _buildNavItem('Dashboard', AppIcons.DASHBOARDICON),
                  _buildNavExpansionItem(
                    'Inventory',
                    AppIcons.INVENTORYICON,
                    ['Brands / Suppliers', 'Purchase', 'Stocks'],
                  ),
                  _buildNavExpansionItem(
                    'Orders',
                    AppIcons.ORDERICON,
                    ['New Order', 'Live / History'],
                  ),
                  _buildNavExpansionItem(
                    'Accounts',
                    AppIcons.ACCOUNSTICON,
                    ['Income / Expense', 'Report'],
                  ),
                  _buildNavItem('Quotation', AppIcons.QUOTATIONICON),
                  _buildNavItem('Invoice / Bill', AppIcons.INVOICEICON),
                  _buildNavItem('Settings', AppIcons.SETTINGSICON),
                ],
              ),
            ),

            // LoopSpring Footer with Primary-to-Secondary Gradient Logo
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(AppColors.PRIMARY),
                        Color(AppColors.SECONDAY),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: const Icon(
                      Icons.all_inclusive,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'LoopSpring Technologies and \nConsultancy PVT. LTD',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 10.5,
                      color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.7),
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, dynamic icon) {
    bool isActive = selectedMenu == title;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(AppColors.PRIMARY).withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Material(
        color: isActive ? const Color(AppColors.PRIMARY) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Get.back();
            onMenuSelected(title);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                HugeIcon(
                  icon: icon,
                  color: isActive
                      ? Colors.white
                      : const Color(AppColors.TEXTSECONDARY),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      color: isActive
                          ? Colors.white
                          : const Color(AppColors.TEXTSECONDARY),
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 13.5,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavExpansionItem(
    String title,
    dynamic icon,
    List<String> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
          child: Row(
            children: [
              HugeIcon(
                icon: icon,
                color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.8),
                size: 19,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(AppColors.TEXTPRIMARY).withValues(alpha: 0.85),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.7),
                size: 18,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 23, bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
            ),
          ),
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children.map((e) {
              bool isActive = selectedMenu == e;
              return Container(
                margin: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(AppColors.PRIMARY)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(AppColors.PRIMARY).withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Get.back();
                      onMenuSelected(e);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: isActive ? 5 : 4,
                            height: isActive ? 5 : 4,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white
                                  : const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              e,
                              style: GoogleFonts.inter(
                                color: isActive
                                    ? Colors.white
                                    : const Color(AppColors.TEXTSECONDARY),
                                fontSize: 13,
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
