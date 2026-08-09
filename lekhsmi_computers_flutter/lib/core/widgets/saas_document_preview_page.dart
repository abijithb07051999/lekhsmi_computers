import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';

class SaaSDocumentPreviewPage extends StatefulWidget {
  final String documentTitle;
  final bool isQuotation;
  final Future<Uint8List> Function(PdfPageFormat format) onLayout;
  final Future<void> Function() onSave;
  final Future<void> Function() onShare;

  const SaaSDocumentPreviewPage({
    super.key,
    required this.documentTitle,
    required this.isQuotation,
    required this.onLayout,
    required this.onSave,
    required this.onShare,
  });

  static Future<void> show(
    BuildContext context, {
    required String documentTitle,
    required bool isQuotation,
    required Future<Uint8List> Function(PdfPageFormat format) onLayout,
    required Future<void> Function() onSave,
    required Future<void> Function() onShare,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SaaSDocumentPreviewPage(
          documentTitle: documentTitle,
          isQuotation: isQuotation,
          onLayout: onLayout,
          onSave: onSave,
          onShare: onShare,
        ),
      ),
    );
  }

  @override
  State<SaaSDocumentPreviewPage> createState() => _SaaSDocumentPreviewPageState();
}

class _SaaSDocumentPreviewPageState extends State<SaaSDocumentPreviewPage> {
  bool _isSaving = false;
  bool _isSharing = false;

  Future<void> _handleSave() async {
    setState(() => _isSaving = true);
    try {
      await widget.onSave();
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _handleShare() async {
    setState(() => _isSharing = true);
    try {
      await widget.onShare();
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Preview ${widget.documentTitle}',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // A4 Document Preview Section
          Expanded(
            child: PdfPreview(
              build: widget.onLayout,
              useActions: false,
              canChangeOrientation: false,
              canChangePageFormat: false,
              maxPageWidth: 700,
              scrollViewDecoration: const BoxDecoration(
                color: Color(0xFFE2E8F0),
              ),
            ),
          ),
          // Bottom Action Bar with TWO distinct buttons: SAVE and SHARE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(
                top: BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Button 1: Save
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSaving ? null : _handleSave,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.save_alt_rounded, size: 18),
                      label: Text(
                        _isSaving ? 'Saving...' : 'Save',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Button 2: Share
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSharing ? null : _handleShare,
                      icon: _isSharing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.share_rounded, size: 18),
                      label: Text(
                        _isSharing ? 'Sharing...' : 'Share',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(AppColors.PRIMARY),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
}
