import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_icons.dart';
import '../controller/settings_controller.dart';

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
          // 1. Enterprise Header Banner
          _buildHeaderBar(controller),

          // 2. Adaptive Desktop Content matching dashboard_view.dart (zero footer space)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 20, 28, 20),
              child: Column(
                children: [
                  // Top Section: Store Identity Card (36% space - flex 36)
                  Expanded(
                    flex: 36,
                    child: _buildStoreIdentityCard(context, controller),
                  ),
                  const SizedBox(height: 16),
                  // Bottom Section: LoopSpring Technologies Portfolio Showcase (64% space - flex 64)
                  Expanded(
                    flex: 64,
                    child: _buildPortfolioShowcaseCard(),
                  ),
                ],
              ),
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
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
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
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Configure Lekhsmi Computers business profile and explore technology partner portfolio',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Styled Date Pill & Refresh
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
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
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(DateTime.now()),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF334155),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Color(AppColors.PRIMARY),
                    size: 20,
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

  // =========================================================================
  // TOP SECTION (30% HEIGHT): LEKHSMI COMPUTERS EXECUTIVE SPLIT BANNER
  // No vertical spacing gaps; horizontal icon layout with 2x2 contact grid
  // =========================================================================
  Widget _buildStoreIdentityCard(
      BuildContext context, SettingsController controller) {
    final isSmall = MediaQuery.of(context).size.width <= 1100 || MediaQuery.of(context).size.height <= 800;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Banner Column (Flex 4): Logo, Verified Profile Box, Edit Button (Zero Empty Space)
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. TOP: Logo Emblem & Store Name
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFFFFF), Color(0xFFEFF6FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFDBEAFE)),
                        ),
                        child: Image.asset(
                          'assets/logo/lexmi_computers_logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.storefront_rounded,
                              color: Color(AppColors.PRIMARY),
                              size: 26,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return Text(
                                controller.storeName.value,
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0F172A),
                                  letterSpacing: -0.4,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                            const SizedBox(height: 3),
                            Text(
                              'Primary Store Profile • Used everywhere',
                              style: GoogleFonts.inter(
                                fontSize: 11.5,
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

                  // 2. MIDDLE: Sleek System Sync & Verification Card (Fills the middle space beautifully with scroll protection)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.verified_rounded,
                                    color: Color(0xFF10B981),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      'ACTIVE & VERIFIED BUSINESS IDENTITY',
                                      style: GoogleFonts.inter(
                                        fontSize: isSmall ? 9.5 : 10.5,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF0F172A),
                                        letterSpacing: 0.6,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Store details automatically synchronize across all PDF Quotations, Invoice Bills, and customer documents.',
                                style: GoogleFonts.inter(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: [
                                  _buildSyncTag(
                                      'Quotation Sync', Icons.check_circle_rounded),
                                  _buildSyncTag(
                                      'Invoice Bill Sync', Icons.check_circle_rounded),
                                  _buildSyncTag(
                                      'PDF Print Ready', Icons.check_circle_rounded),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 3. BOTTOM: Full-Width Primary Edit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showEditDialog(context, controller),
                      icon: const HugeIcon(
                        icon: AppIcons.EDITICON,
                        color: Colors.white,
                        size: 15,
                      ),
                      label: Text(
                        'Edit Store Information',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(AppColors.PRIMARY),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 18),

          // Right Contact Column (Flex 6): 2x2 Grid of Horizontal Contact Cards (No Vertical Gap!)
          Expanded(
            flex: 6,
            child: Obx(() {
              return Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildHorizontalContactCard(
                            label: 'PHONE NUMBER',
                            value: controller.storePhone.value,
                            subtitle: 'Primary support & billing phone',
                            icon: Icons.phone_in_talk_rounded,
                            accentColor: const Color(0xFF3B82F6),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _buildHorizontalContactCard(
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
                  const SizedBox(height: 14),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildHorizontalContactCard(
                            label: 'WEBSITE',
                            value: controller.storeWebsite.value.isEmpty
                                ? 'Not specified'
                                : controller.storeWebsite.value,
                            subtitle: 'Online catalog & business portal',
                            icon: Icons.language_rounded,
                            accentColor: const Color(0xFF10B981),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _buildHorizontalContactCard(
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF10B981)),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal Contact Card: Icon on Left, Text on Right (Zero awkward vertical space)
  Widget _buildHorizontalContactCard({
    required String label,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: accentColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
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

  // =========================================================================
  // BOTTOM SECTION (70% HEIGHT): LOOPSPRING PORTFOLIO CARD (INFINITY ICON)
  // =========================================================================
  Widget _buildPortfolioShowcaseCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall = constraints.maxWidth < 950;
        return _buildPortfolioShowcaseCardInner(isSmall);
      },
    );
  }

  Widget _buildPortfolioShowcaseCardInner(bool isSmall) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Glow background accent
          Positioned(
            right: -80,
            top: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3B82F6).withValues(alpha: 0.16),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(isSmall ? 16 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Partner Header & Contact Bar with INFINITY Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Container(
                              width: isSmall ? 44 : 54,
                              height: isSmall ? 44 : 54,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(AppColors.PRIMARY),
                                    Color(AppColors.SECONDAY),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(AppColors.PRIMARY)
                                        .withValues(alpha: 0.4),
                                    blurRadius: 14,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              // INFINITY ICON ∞ for LoopSpring
                              child: Icon(
                                Icons.all_inclusive_rounded,
                                color: Colors.white,
                                size: isSmall ? 22 : 28,
                              ),
                            ),
                            SizedBox(width: isSmall ? 10 : 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isSmall
                                        ? 'LoopSpring Technologies & Consultancy'
                                        : 'LoopSpring Technologies and Consultancy PVT LTD',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: isSmall ? 15 : 20,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    isSmall
                                        ? 'Full-Stack Digital Innovation Partner'
                                        : 'Architecture, System Design & Full-Stack Digital Innovation Partner',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: isSmall ? 11 : 12.5,
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
                      // Contact Info Pills
                      Expanded(
                        flex: 4,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              _buildDarkContactPill(
                                icon: Icons.language_rounded,
                                text: 'www.loopspring.in',
                                isSmall: isSmall,
                              ),
                              _buildDarkContactPill(
                                icon: Icons.phone_rounded,
                                text: '+91 98943 65935',
                                isSmall: isSmall,
                              ),
                              if (!isSmall)
                                _buildDarkContactPill(
                                  icon: Icons.mail_rounded,
                                  text: 'loopspring2@gmail.com',
                                  isSmall: isSmall,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(
                      color: Colors.white.withValues(alpha: 0.08), height: 1),
                  const SizedBox(height: 16),

                  // 2. 4 Service Expertise Pillars (Fully expands horizontally)
                  Text(
                    'WHAT WE BUILD & CORE TECHNOLOGIES',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF38BDF8),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildPortfolioServiceCard(
                          icon: Icons.web_rounded,
                          title: 'Website & Web App\nDevelopment',
                          subtitle:
                              'Custom high-performance platforms, interactive portals, and scalable cloud applications.',
                          features: [
                            'Full-Stack React & Next.js',
                            'Modern Responsive UI/UX',
                            'Cloud & Database Scaling',
                          ],
                          gradientColors: [
                            const Color(0xFF0284C7),
                            const Color(0xFF38BDF8)
                          ],
                          isSmall: isSmall,
                        ),
                      ),
                      SizedBox(width: isSmall ? 8 : 14),
                      Expanded(
                        child: _buildPortfolioServiceCard(
                          icon: Icons.install_mobile_rounded,
                          title: 'Mobile App\nDevelopment',
                          subtitle:
                              'Delightful native & cross-platform iOS and Android mobile software.',
                          features: [
                            'Flutter & Native Apps',
                            'High-Speed Offline Cache',
                            'App Store Deployment',
                          ],
                          gradientColors: [
                            const Color(0xFF7C3AED),
                            const Color(0xFFA78BFA)
                          ],
                          isSmall: isSmall,
                        ),
                      ),
                      SizedBox(width: isSmall ? 8 : 14),
                      Expanded(
                        child: _buildPortfolioServiceCard(
                          icon: Icons.desktop_mac_rounded,
                          title: 'Desktop Application\nDevelopment',
                          subtitle:
                              'Enterprise cross-platform desktop POS, billing, and system software.',
                          features: [
                            'Windows, macOS & Linux',
                            'Hardware & Printer POS',
                            'Fast Local DB Integration',
                          ],
                          gradientColors: [
                            const Color(0xFF059669),
                            const Color(0xFF34D399)
                          ],
                          isSmall: isSmall,
                        ),
                      ),
                      SizedBox(width: isSmall ? 8 : 14),
                      Expanded(
                        child: _buildPortfolioServiceCard(
                          icon: Icons.campaign_rounded,
                          title: 'Digital\nMarketing',
                          subtitle:
                              'Strategic SEO, targeted marketing campaigns, and data-driven brand acceleration.',
                          features: [
                            'Search Engine Optimization',
                            'Brand & Growth Campaigns',
                            'Targeted Lead Generation',
                          ],
                          gradientColors: [
                            const Color(0xFFD97706),
                            const Color(0xFFFBBF24)
                          ],
                          isSmall: isSmall,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 3. Complete Enterprise Software Suite
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.all_inclusive_rounded,
                              color: Color(0xFF38BDF8),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'COMPLETE ENTERPRISE SOFTWARE SUITE (READY & CUSTOM BUILT)',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF38BDF8),
                                  letterSpacing: 1.2,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: isSmall ? 8 : 12,
                            runSpacing: isSmall ? 8 : 12,
                            children: [
                              _buildSoftwareTag(
                                  'CRM Software', Icons.people_alt_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('ERP Software',
                                  Icons.account_tree_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('Accounting Software',
                                  Icons.calculate_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('E-Commerce Software',
                                  Icons.shopping_bag_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag(
                                  'Billing Software', Icons.receipt_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('Matrimony Software',
                                  Icons.favorite_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('Inventory & POS Software',
                                  Icons.inventory_2_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('HRM & Payroll Systems',
                                  Icons.badge_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('Hospital Management',
                                  Icons.local_hospital_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag('School & College EMS',
                                  Icons.school_rounded,
                                  isSmall: isSmall),
                              _buildSoftwareTag(
                                  'Custom Enterprise Workflows',
                                  Icons.hub_rounded,
                                  isSmall: isSmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // 4. Partner Location Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 15,
                              color: Color(0xFF64748B),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '13 E.J.M. Complex, Opp. RTO Office, Mulagumoodu, Kanyakumari, Tamilnadu, India - 629167',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontSize: isSmall ? 10.5 : 12,
                                  color: const Color(0xFF94A3B8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'LOOPSPRING.IN',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF475569),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDarkContactPill({required IconData icon, required String text, bool isSmall = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 12, vertical: isSmall ? 5 : 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmall ? 11 : 13, color: const Color(0xFF38BDF8)),
          SizedBox(width: isSmall ? 4 : 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: isSmall ? 10.5 : 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> features,
    required List<Color> gradientColors,
    bool isSmall = false,
  }) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 10 : 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: isSmall ? 28 : 38,
                height: isSmall ? 28 : 38,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: isSmall ? 14 : 20),
              ),
              SizedBox(width: isSmall ? 6 : 10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: isSmall ? 11 : 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isSmall ? 4 : 8),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: isSmall ? 9.5 : 11,
              color: const Color(0xFF94A3B8),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: isSmall ? 4 : 10),
          Divider(color: Colors.white.withValues(alpha: 0.06), height: 1),
          SizedBox(height: isSmall ? 4 : 10),
          ...features.map(
            (f) => Padding(
              padding: EdgeInsets.only(bottom: isSmall ? 4 : 6),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: isSmall ? 11 : 13,
                    color: gradientColors[1],
                  ),
                  SizedBox(width: isSmall ? 4 : 6),
                  Expanded(
                    child: Text(
                      f,
                      style: GoogleFonts.inter(
                        fontSize: isSmall ? 9.5 : 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFE2E8F0),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftwareTag(String name, IconData icon, {bool isSmall = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 12, vertical: isSmall ? 5 : 8),
      decoration: BoxDecoration(
        color: const Color(0xFF38BDF8).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF38BDF8).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmall ? 12 : 14, color: const Color(0xFF38BDF8)),
          SizedBox(width: isSmall ? 4 : 6),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: isSmall ? 10.5 : 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF38BDF8),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EDIT STORE INFORMATION MODAL DIALOG
  // ==========================================
  void _showEditDialog(BuildContext context, SettingsController controller) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(text: controller.storeName.value);
    final phoneCtrl = TextEditingController(text: controller.storePhone.value);
    final emailCtrl = TextEditingController(text: controller.storeEmail.value);
    final websiteCtrl =
        TextEditingController(text: controller.storeWebsite.value);
    final addressCtrl =
        TextEditingController(text: controller.storeAddress.value);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 580,
            padding: const EdgeInsets.all(28),
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
                            width: 40,
                            height: 40,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Image.asset(
                              'assets/logo/lexmi_computers_logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.storefront,
                                  color: Color(AppColors.PRIMARY),
                                  size: 20,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            'Edit Store Information',
                            style: GoogleFonts.inter(
                              fontSize: 18,
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
                  const SizedBox(height: 6),
                  Text(
                    'Update business details used in Quotations, Bills & Invoices.',
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      color: const Color(AppColors.TEXTSECONDARY),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Store Name *',
                    controller: nameCtrl,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Store Name is required'
                        : null,
                  ),
                  const SizedBox(height: 16),
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
                      const SizedBox(width: 16),
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
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Website [Optional]',
                    controller: websiteCtrl,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Address *',
                    controller: addressCtrl,
                    maxLines: 2,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Address is required'
                        : null,
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
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
                      const SizedBox(width: 12),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  final success =
                                      await controller.updateStoreSettings(
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
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
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
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(AppColors.TEXTSECONDARY),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.inter(
            fontSize: 13.5,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(AppColors.PRIMARY)),
            ),
          ),
        ),
      ],
    );
  }
}
