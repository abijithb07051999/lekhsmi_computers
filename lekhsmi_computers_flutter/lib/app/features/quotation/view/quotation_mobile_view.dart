import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_document_preview_page.dart';
import 'package:lekhsmi_computers_flutter/app/features/quotation/controller/quotation_controller.dart';

class QuotationMobileView extends StatelessWidget {
  final QuotationController controller;
  final Widget Function(QuotationController) buildTitleSection;
  final Widget Function(BuildContext, QuotationController) buildFormSection;

  const QuotationMobileView({
    super.key,
    required this.controller,
    required this.buildTitleSection,
    required this.buildFormSection,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildTitleSection(controller),
          Expanded(
            child: buildFormSection(context, controller),
          ),
        ],
      ),
      bottomNavigationBar: _buildMobilePreviewButtonBar(context, controller),
    );
  }

  Widget _buildMobilePreviewButtonBar(BuildContext context, QuotationController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton.icon(
          onPressed: () {
            if (controller.validateBeforePrint()) {
              SaaSDocumentPreviewPage.show(
                context,
                documentTitle: 'QUOTATION',
                isQuotation: true,
                onLayout: controller.generatePdfBytes,
                onSave: controller.saveQuotationPdf,
                onShare: controller.shareQuotationPdf,
              );
            }
          },
          icon: const Icon(Icons.visibility_rounded, size: 20),
          label: Text(
            'Preview Quotation',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(AppColors.PRIMARY),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
