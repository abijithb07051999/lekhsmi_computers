import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_icons.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import 'settings_view.dart';

class SettingsMobileView extends StatelessWidget {
  final SettingsController controller;

  const SettingsMobileView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Column(
        children: [
          _buildMobileStoreIdentityCard(context, controller),
          const SizedBox(height: 20),
          _buildMobilePortfolioCard(),
        ],
      ),
    );
  }

  Widget _buildMobileStoreIdentityCard(
    BuildContext context,
    SettingsController controller,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store logo & identity box
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Image.asset(
                        'assets/logo/lexmi_computers_logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.storefront_rounded,
                          color: Color(AppColors.PRIMARY),
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.storeName.value,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.verified_rounded, color: Color(0xFF10B981), size: 12),
                                const SizedBox(width: 4),
                                Text(
                                  'VERIFIED BUSINESS',
                                  style: GoogleFonts.inter(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF10B981),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: Color(AppColors.PRIMARY),
                        size: 22,
                      ),
                      tooltip: 'Refresh Store Settings',
                      onPressed: () => controller.fetchStoreSettings(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Store details synchronize across all PDF Quotations, Invoice Bills, and customer documents.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SettingsDialogs.buildSyncTag('Quotation Sync', Icons.check_circle_rounded),
                    SettingsDialogs.buildSyncTag('Invoice Bill Sync', Icons.check_circle_rounded),
                    SettingsDialogs.buildSyncTag('PDF Print Ready', Icons.check_circle_rounded),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => SettingsDialogs.showEditDialog(context, controller),
                    icon: const HugeIcon(
                      icon: AppIcons.EDITICON,
                      color: Color(AppColors.PRIMARY),
                      size: 16,
                    ),
                    label: Text(
                      'Edit Store Information',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                      foregroundColor: const Color(AppColors.PRIMARY),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Vertical Contact Cards
          Obx(() {
            return Column(
              children: [
                _buildEliteContactCard(
                  label: 'PHONE NUMBER',
                  value: controller.storePhone.value,
                  subtitle: 'Primary support & billing phone',
                  icon: Icons.phone_in_talk_rounded,
                  accentColor: const Color(0xFF3B82F6),
                ),
                const SizedBox(height: 12),
                _buildEliteContactCard(
                  label: 'EMAIL ADDRESS',
                  value: controller.storeEmail.value,
                  subtitle: 'Official business correspondence',
                  icon: Icons.alternate_email_rounded,
                  accentColor: const Color(0xFF6366F1),
                ),
                const SizedBox(height: 12),
                _buildEliteContactCard(
                  label: 'WEBSITE',
                  value: controller.storeWebsite.value.isEmpty
                      ? 'Not specified'
                      : controller.storeWebsite.value,
                  subtitle: 'Online catalog & business portal',
                  icon: Icons.language_rounded,
                  accentColor: const Color(0xFF10B981),
                ),
                const SizedBox(height: 12),
                _buildEliteContactCard(
                  label: 'STORE ADDRESS',
                  value: controller.storeAddress.value,
                  subtitle: 'Official showroom & billing location',
                  icon: Icons.location_on_rounded,
                  accentColor: const Color(0xFFF59E0B),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEliteContactCard({
    required String label,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accentColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: const Color(AppColors.TEXTSECONDARY),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(AppColors.TEXTPRIMARY),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(AppColors.TEXTSECONDARY).withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePortfolioCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMobilePortfolioHeader(),
                const SizedBox(height: 16),
                Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
                const SizedBox(height: 16),
                Text(
                  'WHAT WE BUILD & CORE TECHNOLOGIES',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF38BDF8),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMobileServiceCard(
                  icon: Icons.web_rounded,
                  title: 'Website & Web App Development',
                  subtitle: 'High-performance platforms, interactive portals & scalable cloud apps.',
                  features: ['Full-Stack React & Next.js', 'Modern Responsive UI/UX', 'Cloud & Database Scaling'],
                  colors: [const Color(0xFF0284C7), const Color(0xFF38BDF8)],
                ),
                const SizedBox(height: 12),
                _buildMobileServiceCard(
                  icon: Icons.install_mobile_rounded,
                  title: 'Mobile App Development',
                  subtitle: 'Native & cross-platform iOS and Android mobile software.',
                  features: ['Flutter & Native Apps', 'High-Speed Offline Cache', 'App Store Deployment'],
                  colors: [const Color(0xFF7C3AED), const Color(0xFFA78BFA)],
                ),
                const SizedBox(height: 12),
                _buildMobileServiceCard(
                  icon: Icons.desktop_mac_rounded,
                  title: 'Desktop Application Development',
                  subtitle: 'Enterprise cross-platform POS, billing & system software.',
                  features: ['Windows, macOS & Linux', 'Hardware & Printer POS', 'Fast Local DB Integration'],
                  colors: [const Color(0xFF059669), const Color(0xFF34D399)],
                ),
                const SizedBox(height: 12),
                _buildMobileServiceCard(
                  icon: Icons.campaign_rounded,
                  title: 'Digital Marketing',
                  subtitle: 'Strategic SEO, campaigns & data-driven brand acceleration.',
                  features: ['Search Engine Optimization', 'Brand & Growth Campaigns', 'Targeted Lead Generation'],
                  colors: [const Color(0xFFD97706), const Color(0xFFFBBF24)],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(16),
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
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'ENTERPRISE SOFTWARE SUITE',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF38BDF8),
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          SettingsDialogs.buildSoftwareTag('CRM Software', Icons.people_alt_rounded),
                          SettingsDialogs.buildSoftwareTag('ERP Software', Icons.account_tree_rounded),
                          SettingsDialogs.buildSoftwareTag('Accounting Software', Icons.calculate_rounded),
                          SettingsDialogs.buildSoftwareTag('E-Commerce Software', Icons.shopping_bag_rounded),
                          SettingsDialogs.buildSoftwareTag('Billing Software', Icons.receipt_rounded),
                          SettingsDialogs.buildSoftwareTag('Matrimony Software', Icons.favorite_rounded),
                          SettingsDialogs.buildSoftwareTag('Inventory & POS Software', Icons.inventory_2_rounded),
                          SettingsDialogs.buildSoftwareTag('HRM & Payroll Systems', Icons.badge_rounded),
                          SettingsDialogs.buildSoftwareTag('Hospital Management', Icons.local_hospital_rounded),
                          SettingsDialogs.buildSoftwareTag('School & College EMS', Icons.school_rounded),
                          SettingsDialogs.buildSoftwareTag('Custom Enterprise Workflows', Icons.hub_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '13 E.J.M. Complex, Opp. RTO Office, Mulagumoodu, Kanyakumari, Tamilnadu, India - 629167',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                          height: 1.4,
                        ),
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

  Widget _buildMobileServiceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<String> features,
    required List<Color> colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 13,
                          color: colors[1],
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            f,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFE2E8F0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePortfolioHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
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
                    color: const Color(AppColors.PRIMARY).withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.all_inclusive_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LoopSpring Technologies',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Architecture, System Design & Innovation',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildContactPill(Icons.language_rounded, 'www.loopspring.in'),
            _buildContactPill(Icons.phone_rounded, '+91 98943 65935'),
            _buildContactPill(Icons.mail_rounded, 'loopspring2@gmail.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildContactPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF38BDF8)),
          const SizedBox(width: 6),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
