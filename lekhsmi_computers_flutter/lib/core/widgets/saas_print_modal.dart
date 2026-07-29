import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';

class SaaSPrintModal extends StatefulWidget {
  final String documentTitle;
  final String documentNumber;
  final String customerName;
  final String totalAmountText;
  final Future<Uint8List> Function(PdfPageFormat format) onLayout;

  const SaaSPrintModal({
    super.key,
    required this.documentTitle,
    required this.documentNumber,
    required this.customerName,
    required this.totalAmountText,
    required this.onLayout,
  });

  static Future<bool> show({
    required String documentTitle,
    required String documentNumber,
    required String customerName,
    required String totalAmountText,
    required Future<Uint8List> Function(PdfPageFormat format) onLayout,
  }) async {
    final result = await Get.dialog<bool>(
      SaaSPrintModal(
        documentTitle: documentTitle,
        documentNumber: documentNumber,
        customerName: customerName,
        totalAmountText: totalAmountText,
        onLayout: onLayout,
      ),
      barrierDismissible: false,
    );
    return result ?? false;
  }

  @override
  State<SaaSPrintModal> createState() => _SaaSPrintModalState();
}

class _SaaSPrintModalState extends State<SaaSPrintModal>
    with SingleTickerProviderStateMixin {
  List<Printer> _printers = [];
  Printer? _selectedPrinter;
  bool _isLoadingPrinters = true;
  bool _isPrinting = false;
  bool _printSuccess = false;
  int _copies = 1;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSystemPrinters();
  }

  Future<void> _loadSystemPrinters() async {
    setState(() {
      _isLoadingPrinters = true;
      _errorMessage = null;
    });

    try {
      final printers = await Printing.listPrinters();
      Printer? defaultPrinter;

      for (final p in printers) {
        if (p.isDefault) {
          defaultPrinter = p;
          break;
        }
      }

      setState(() {
        _printers = printers;
        _selectedPrinter = defaultPrinter ?? (printers.isNotEmpty ? printers.first : null);
        _isLoadingPrinters = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingPrinters = false;
        _errorMessage = 'Could not detect connected printers: $e';
      });
    }
  }

  Future<void> _handleDirectPrint() async {
    if (_selectedPrinter == null) return;

    setState(() {
      _isPrinting = true;
      _errorMessage = null;
    });

    try {
      final success = await Printing.directPrintPdf(
        printer: _selectedPrinter!,
        onLayout: widget.onLayout,
        name: '${widget.documentTitle}_${widget.documentNumber}',
      );

      if (success) {
        setState(() {
          _isPrinting = false;
          _printSuccess = true;
        });
        await Future.delayed(const Duration(milliseconds: 700));
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      } else {
        setState(() {
          _isPrinting = false;
          _errorMessage = 'Print job was cancelled or not completed.';
        });
      }
    } catch (e) {
      setState(() {
        _isPrinting = false;
        _errorMessage = 'Printing error: $e';
      });
    }
  }

  Future<void> _handleLegacyOSDialog() async {
    try {
      final bool printed = await Printing.layoutPdf(
        onLayout: widget.onLayout,
        name: '${widget.documentTitle}_${widget.documentNumber}',
      );
      if (printed && mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'OS dialog error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 460,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPrinterSelectionSection(),
                  const SizedBox(height: 20),
                  _buildCopiesRow(),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    _buildErrorBanner(_errorMessage!),
                  ],
                  if (_printSuccess) ...[
                    const SizedBox(height: 16),
                    _buildSuccessBanner(),
                  ],
                ],
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.print_rounded,
              color: Color(AppColors.PRIMARY),
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Print ${widget.documentTitle}',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.customerName} • ${widget.totalAmountText}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(false),
            icon: const Icon(Icons.close_rounded, color: Color(0xFF94A3B8), size: 20),
            splashRadius: 18,
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _buildPrinterSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Printer',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF334155),
              ),
            ),
            InkWell(
              onTap: _isLoadingPrinters ? null : _loadSystemPrinters,
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      size: 14,
                      color: _isLoadingPrinters
                          ? const Color(0xFF94A3B8)
                          : const Color(AppColors.PRIMARY),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Refresh',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _isLoadingPrinters
                            ? const Color(0xFF94A3B8)
                            : const Color(AppColors.PRIMARY),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: _isLoadingPrinters
              ? _buildShimmerPrinterLoader()
              : _printers.isEmpty
                  ? _buildNoPrintersState()
                  : _buildPrinterDropdown(),
        ),
      ],
    );
  }

  Widget _buildShimmerPrinterLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Color(AppColors.PRIMARY)),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Detecting printers...',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoPrintersState() {
    return Row(
      children: [
        const Icon(Icons.print_disabled_rounded, color: Color(0xFFEF4444), size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'No connected printers found',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrinterDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Printer>(
        value: _selectedPrinter,
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B), size: 20),
        onChanged: (Printer? newValue) {
          setState(() {
            _selectedPrinter = newValue;
          });
        },
        items: _printers.map((Printer printer) {
          final isPrimary = printer.isDefault;
          return DropdownMenuItem<Printer>(
            value: printer,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    printer.name,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w500,
                      color: const Color(0xFF0F172A),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isPrimary) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: Text(
                      'Default',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(AppColors.PRIMARY),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCopiesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Copies',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _copies > 1 ? () => setState(() => _copies--) : null,
                    icon: const Icon(Icons.remove_rounded, size: 16),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    splashRadius: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '$_copies',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _copies++),
                    icon: const Icon(Icons.add_rounded, size: 16),
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    splashRadius: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            TextButton(
              onPressed: _handleLegacyOSDialog,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                foregroundColor: const Color(0xFF64748B),
              ),
              child: Text(
                'System dialog',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorBanner(String message) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded, color: Color(0xFFEF4444), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFB91C1C),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Document printed successfully!',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF047857),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _isPrinting ? null : () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              foregroundColor: const Color(0xFF64748B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            onPressed: (_isPrinting || _selectedPrinter == null) ? null : _handleDirectPrint,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppColors.PRIMARY),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: _isPrinting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.print_rounded, size: 18),
            label: Text(
              _isPrinting ? 'Printing...' : 'Print',
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
