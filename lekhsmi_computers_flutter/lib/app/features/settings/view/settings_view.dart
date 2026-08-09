import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_icons.dart';
import 'package:lekhsmi_computers_flutter/core/utils/responsive_utils.dart';
import '../controller/settings_controller.dart';
import 'settings_mobile_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          _buildHeaderBar(controller),
          Expanded(
            child: ResponsiveUtils.isPhone(context)
                ? SettingsMobileView(controller: controller)
                : LayoutBuilder(
                    builder: (context, constraints) {
                      const double gap = 12;
                      const double padV = 14;
                      const double padH = 18;
                      final double available =
                          constraints.maxHeight - padV * 2 - gap;
                      double topH = available * 0.30;
                      double botH = available * 0.70;

                      topH = math.max(topH, 260.0);
                      botH = math.max(botH, 540.0);

                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: SizedBox(
                            width: math.max(constraints.maxWidth, 1100.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: padH,
                                vertical: padV,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: topH,
                                    child: _buildStoreIdentityCard(
                                      context,
                                      controller,
                                    ),
                                  ),
                                  const SizedBox(height: gap),
                                  SizedBox(
                                    height: botH,
                                    child: _buildPortfolioCard(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBar(SettingsController controller) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings & Store Identity',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Configure Lekhsmi Computers business profile and explore technology partner portfolio',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const HugeIcon(
                      icon: AppIcons.CALENDARICON,
                      color: Color(0xFF64748B),
                      size: 14,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      _formatDate(DateTime.now()),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF334155),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Color(AppColors.PRIMARY),
                    size: 18,
                  ),
                  tooltip: 'Refresh Store Settings',
                  onPressed: () => controller.fetchStoreSettings(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
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
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  // ===========================================================================
  // TOP 30% — LEKHSMI COMPUTERS STORE IDENTITY
  // ===========================================================================
  Widget _buildStoreIdentityCard(
    BuildContext context,
    SettingsController controller,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // Left pane
          Expanded(
            flex: 36,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo row
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFFFFF), Color(0xFFEFF6FF)],
                          ),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: const Color(0xFFDBEAFE)),
                        ),
                        child: Image.asset(
                          'assets/logo/lexmi_computers_logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.storefront_rounded,
                            color: Color(AppColors.PRIMARY),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                controller.storeName.value,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0F172A),
                                  letterSpacing: -0.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Primary Store Profile • Used everywhere',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF64748B),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Verified badge box
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.verified_rounded,
                                color: Color(0xFF10B981),
                                size: 13,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  'ACTIVE & VERIFIED BUSINESS IDENTITY',
                                  style: GoogleFonts.inter(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF0F172A),
                                    letterSpacing: 0.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Store details synchronize across all PDF Quotations, Invoice Bills, and customer documents.',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: const Color(0xFF64748B),
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 5,
                            runSpacing: 4,
                            children: [
                              _buildSyncTag(
                                'Quotation Sync',
                                Icons.check_circle_rounded,
                              ),
                              _buildSyncTag(
                                'Invoice Bill Sync',
                                Icons.check_circle_rounded,
                              ),
                              _buildSyncTag(
                                'PDF Print Ready',
                                Icons.check_circle_rounded,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Edit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showEditDialog(context, controller),
                      icon: const HugeIcon(
                        icon: AppIcons.EDITICON,
                        color: Colors.white,
                        size: 13,
                      ),
                      label: Text(
                        'Edit Store Information',
                        style: GoogleFonts.inter(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(AppColors.PRIMARY),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Right pane: 2x2 contact grid
          Expanded(
            flex: 64,
            child: Obx(() {
              return Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildContactCard(
                            label: 'PHONE NUMBER',
                            value: controller.storePhone.value,
                            subtitle: 'Primary support & billing phone',
                            icon: Icons.phone_in_talk_rounded,
                            accentColor: const Color(0xFF3B82F6),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildContactCard(
                            label: 'EMAIL ADDRESS',
                            value: controller.storeEmail.value,
                            subtitle: 'Official business correspondence',
                            icon: Icons.alternate_email_rounded,
                            accentColor: const Color(0xFF6366F1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildContactCard(
                            label: 'WEBSITE',
                            value: controller.storeWebsite.value.isEmpty
                                ? 'Not specified'
                                : controller.storeWebsite.value,
                            subtitle: 'Online catalog & business portal',
                            icon: Icons.language_rounded,
                            accentColor: const Color(0xFF10B981),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildContactCard(
                            label: 'STORE ADDRESS',
                            value: controller.storeAddress.value,
                            subtitle: 'Official showroom & billing location',
                            icon: Icons.location_on_rounded,
                            accentColor: const Color(0xFFF59E0B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSyncTag(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: const Color(0xFF10B981)),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String label,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: accentColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // BOTTOM 70% — LOOPSPRING PORTFOLIO CARD
  // ===========================================================================
  Widget _buildPortfolioCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background glow accent
          Positioned(
            right: -60,
            top: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3B82F6).withValues(alpha: 0.14),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────────
                _buildPortfolioHeader(),
                const SizedBox(height: 10),
                Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
                const SizedBox(height: 10),

                // ── Section label ────────────────────────────────────────────
                Text(
                  'WHAT WE BUILD & CORE TECHNOLOGIES',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF38BDF8),
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 8),

                // ── 4 service cards ──────────────────────────────────────────
                Expanded(
                  flex: 52,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.web_rounded,
                          title: 'Website & Web App\nDevelopment',
                          subtitle:
                              'High-performance platforms, interactive portals & scalable cloud apps.',
                          features: [
                            'Full-Stack React & Next.js',
                            'Modern Responsive UI/UX',
                            'Cloud & Database Scaling',
                          ],
                          colors: [
                            const Color(0xFF0284C7),
                            const Color(0xFF38BDF8),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.install_mobile_rounded,
                          title: 'Mobile App\nDevelopment',
                          subtitle:
                              'Native & cross-platform iOS and Android mobile software.',
                          features: [
                            'Flutter & Native Apps',
                            'High-Speed Offline Cache',
                            'App Store Deployment',
                          ],
                          colors: [
                            const Color(0xFF7C3AED),
                            const Color(0xFFA78BFA),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.desktop_mac_rounded,
                          title: 'Desktop Application\nDevelopment',
                          subtitle:
                              'Enterprise cross-platform POS, billing & system software.',
                          features: [
                            'Windows, macOS & Linux',
                            'Hardware & Printer POS',
                            'Fast Local DB Integration',
                          ],
                          colors: [
                            const Color(0xFF059669),
                            const Color(0xFF34D399),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.campaign_rounded,
                          title: 'Digital\nMarketing',
                          subtitle:
                              'Strategic SEO, campaigns & data-driven brand acceleration.',
                          features: [
                            'Search Engine Optimization',
                            'Brand & Growth Campaigns',
                            'Targeted Lead Generation',
                          ],
                          colors: [
                            const Color(0xFFD97706),
                            const Color(0xFFFBBF24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ── Enterprise software suite ────────────────────────────────
                Expanded(
                  flex: 34,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.all_inclusive_rounded,
                              color: Color(0xFF38BDF8),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'SPECIALIZED ENTERPRISE SOFTWARE SUITE & CUSTOM SYSTEMS',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF38BDF8),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                _buildSoftwareTag(
                                  'CRM Software',
                                  Icons.people_alt_rounded,
                                ),
                                _buildSoftwareTag(
                                  'ERP Software',
                                  Icons.account_tree_rounded,
                                ),
                                _buildSoftwareTag(
                                  'Accounting Software',
                                  Icons.calculate_rounded,
                                ),
                                _buildSoftwareTag(
                                  'E-Commerce Software',
                                  Icons.shopping_bag_rounded,
                                ),
                                _buildSoftwareTag(
                                  'Billing Software',
                                  Icons.receipt_rounded,
                                ),
                                _buildSoftwareTag(
                                  'Matrimony Software',
                                  Icons.favorite_rounded,
                                ),
                                _buildSoftwareTag(
                                  'Inventory & POS Software',
                                  Icons.inventory_2_rounded,
                                ),
                                _buildSoftwareTag(
                                  'HRM & Payroll Systems',
                                  Icons.badge_rounded,
                                ),
                                _buildSoftwareTag(
                                  'Hospital Management',
                                  Icons.local_hospital_rounded,
                                ),
                                _buildSoftwareTag(
                                  'School & College EMS',
                                  Icons.school_rounded,
                                ),
                                _buildSoftwareTag(
                                  'Custom Enterprise Workflows',
                                  Icons.hub_rounded,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // ── Footer ───────────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: Color(0xFF64748B),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              '13 E.J.M. Complex, Opp. RTO Office, Mulagumoodu, Kanyakumari, Tamilnadu, India - 629167',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF94A3B8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'LOOPSPRING.IN',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF475569),
                        letterSpacing: 1.4,
                      ),
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

  Widget _buildPortfolioHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(AppColors.PRIMARY),
                      Color(AppColors.SECONDAY),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        AppColors.PRIMARY,
                      ).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.all_inclusive_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LoopSpring Technologies and Consultancy PVT LTD',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Architecture, System Design & Full-Stack Digital Innovation Partner',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              alignment: WrapAlignment.end,
              spacing: 6,
              runSpacing: 5,
              children: [
                _buildContactPill(Icons.language_rounded, 'www.loopspring.in'),
                _buildContactPill(Icons.phone_rounded, '+91 98943 65935'),
                _buildContactPill(Icons.mail_rounded, 'loopspring2@gmail.com'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF38BDF8)),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> features,
    required List<Color> colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF94A3B8),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          const SizedBox(height: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map(
                    (f) => Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: colors[1],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            f,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFE2E8F0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftwareTag(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF38BDF8).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF38BDF8).withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF38BDF8)),
          const SizedBox(width: 6),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF38BDF8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // EDIT STORE INFORMATION DIALOG
  // ===========================================================================
  void _showEditDialog(BuildContext context, SettingsController controller) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(text: controller.storeName.value);
    final phoneCtrl = TextEditingController(text: controller.storePhone.value);
    final emailCtrl = TextEditingController(text: controller.storeEmail.value);
    final websiteCtrl = TextEditingController(
      text: controller.storeWebsite.value,
    );
    final addressCtrl = TextEditingController(
      text: controller.storeAddress.value,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 560,
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Image.asset(
                              'assets/logo/lexmi_computers_logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => const Icon(
                                Icons.storefront,
                                color: Color(AppColors.PRIMARY),
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Edit Store Information',
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: Color(AppColors.TEXTSECONDARY),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Update business details used in Quotations, Bills & Invoices.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(AppColors.TEXTSECONDARY),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    label: 'Store Name *',
                    controller: nameCtrl,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Store Name is required'
                        : null,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Phone Number *',
                          controller: phoneCtrl,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Phone is required'
                              : null,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _buildTextField(
                          label: 'Email Address *',
                          controller: emailCtrl,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Email is required'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    label: 'Website [Optional]',
                    controller: websiteCtrl,
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    label: 'Address *',
                    controller: addressCtrl,
                    maxLines: 2,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Address is required'
                        : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  final success = await controller
                                      .updateStoreSettings(
                                        name: nameCtrl.text.trim(),
                                        phone: phoneCtrl.text.trim(),
                                        email: emailCtrl.text.trim(),
                                        website: websiteCtrl.text.trim(),
                                        address: addressCtrl.text.trim(),
                                      );
                                  if (success && context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(AppColors.PRIMARY),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Save Changes',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(AppColors.TEXTSECONDARY),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(AppColors.PRIMARY)),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsDialogs {
  static Widget buildSyncTag(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: const Color(0xFF10B981)),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildContactCard({
    required String label,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: accentColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildPortfolioHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(AppColors.PRIMARY),
                      Color(AppColors.SECONDAY),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        AppColors.PRIMARY,
                      ).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.all_inclusive_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LoopSpring Technologies and Consultancy PVT LTD',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Architecture, System Design & Full-Stack Digital Innovation Partner',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              alignment: WrapAlignment.end,
              spacing: 6,
              runSpacing: 5,
              children: [
                _buildContactPill(Icons.language_rounded, 'www.loopspring.in'),
                _buildContactPill(Icons.phone_rounded, '+91 98943 65935'),
                _buildContactPill(Icons.mail_rounded, 'loopspring2@gmail.com'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildContactPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF38BDF8)),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> features,
    required List<Color> colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF94A3B8),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          const SizedBox(height: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map(
                    (f) => Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14,
                          color: colors[1],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            f,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFE2E8F0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildSoftwareTag(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF38BDF8).withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF38BDF8).withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF38BDF8)),
          const SizedBox(width: 6),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF38BDF8),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // EDIT STORE INFORMATION DIALOG
  // ===========================================================================
  static void showEditDialog(
    BuildContext context,
    SettingsController controller,
  ) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(text: controller.storeName.value);
    final phoneCtrl = TextEditingController(text: controller.storePhone.value);
    final emailCtrl = TextEditingController(text: controller.storeEmail.value);
    final websiteCtrl = TextEditingController(
      text: controller.storeWebsite.value,
    );
    final addressCtrl = TextEditingController(
      text: controller.storeAddress.value,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Container(
            width: 560,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Image.asset(
                                'assets/logo/lexmi_computers_logo.png',
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.storefront,
                                  color: Color(AppColors.PRIMARY),
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Edit Store Information',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.close,
                            color: Color(AppColors.TEXTSECONDARY),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Update business details used in Quotations, Bills & Invoices.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(AppColors.TEXTSECONDARY),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _buildTextField(
                      label: 'Store Name *',
                      controller: nameCtrl,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Store Name is required'
                          : null,
                    ),
                    const SizedBox(height: 14),
                    if (ResponsiveUtils.isPhone(context)) ...[
                      _buildTextField(
                        label: 'Phone Number *',
                        controller: phoneCtrl,
                        keyboardType: TextInputType.phone,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Phone is required'
                            : null,
                      ),
                      const SizedBox(height: 14),
                      _buildTextField(
                        label: 'Email Address *',
                        controller: emailCtrl,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Email is required'
                            : null,
                      ),
                    ] else
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              label: 'Phone Number *',
                              controller: phoneCtrl,
                              keyboardType: TextInputType.phone,
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Phone is required'
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildTextField(
                              label: 'Email Address *',
                              controller: emailCtrl,
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Email is required'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 14),
                    _buildTextField(
                      label: 'Website [Optional]',
                      controller: websiteCtrl,
                    ),
                    const SizedBox(height: 14),
                    _buildTextField(
                      label: 'Address *',
                      controller: addressCtrl,
                      maxLines: 2,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Address is required'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(AppColors.TEXTSECONDARY),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(() {
                          return ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () async {
                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }
                                    final success = await controller
                                        .updateStoreSettings(
                                          name: nameCtrl.text.trim(),
                                          phone: phoneCtrl.text.trim(),
                                          email: emailCtrl.text.trim(),
                                          website: websiteCtrl.text.trim(),
                                          address: addressCtrl.text.trim(),
                                        );
                                    if (success && context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(AppColors.PRIMARY),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Save Changes',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
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
        );
      },
    );
  }

  static Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(AppColors.TEXTSECONDARY),
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(color: Color(AppColors.PRIMARY)),
            ),
          ),
        ),
      ],
    );
  }
}
