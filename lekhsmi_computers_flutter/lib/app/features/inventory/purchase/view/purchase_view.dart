import 'package:flutter/material.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_dropdown.dart';
import 'package:lekhsmi_computers_flutter/core/utils/responsive_utils.dart';
import 'package:lekhsmi_computers_flutter/app/features/inventory/purchase/controller/purchase_controller.dart';
import 'purchase_mobile_view.dart';

class _PurchaseItemFormRow {
  final String id = UniqueKey().toString();
  int? productId;
  int quantity = 1;
  int unitPrice = 0;

  final TextEditingController qtyCtrl = TextEditingController();

  int get subtotal => quantity * unitPrice;

  void dispose() {
    qtyCtrl.dispose();
  }
}

class PurchaseView extends StatefulWidget {
  const PurchaseView({super.key});

  @override
  State<PurchaseView> createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  final PurchaseController controller = Get.put(PurchaseController());

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isPhone(context)) {
      return const PurchaseMobileView();
    }
    return Column(
      children: [
        // Top Header Section (White Card Bar)
        _buildTitleSection(),
        // Content Area
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
            child: _buildPurchasesTableSection(context),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(AppColors.WHITE),
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 700;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        'Purchases & Stock History',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: isSmall ? 15 : 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(AppColors.TEXTPRIMARY),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'RECORDS',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(AppColors.PRIMARY),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isSmall) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded, size: 14, color: Color(AppColors.TEXTSECONDARY)),
                          const SizedBox(width: 8),
                          Text(
                            PurchaseDialogs.formatDate(DateTime.now()),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(AppColors.TEXTPRIMARY),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.refreshAll(),
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
          );
        },
      ),
    );
  }

  Widget _buildPurchasesTableSection(BuildContext context) {
    return Container(
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
          // Action Bar (Search + Add Button)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      onChanged: (value) => controller.searchQuery.value = value,
                      style: GoogleFonts.inter(
                        fontSize: 13.5,
                        color: const Color(AppColors.TEXTPRIMARY),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Search by Invoice No, Supplier, Status...',
                        hintStyle: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w400,
                          color: const Color(AppColors.HINTTEXT),
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(AppColors.TEXTSECONDARY),
                          size: 18,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => PurchaseDialogs.showAddPurchaseDialog(context),
                    icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                    label: Text(
                      'Add New Purchase',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(AppColors.PRIMARY),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          // Table Section
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double minWidth = 680.0;
                final double tableWidth = constraints.maxWidth < minWidth
                    ? minWidth
                    : constraints.maxWidth;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      children: [
                        _buildTableHeader(),
                        Expanded(
                          child: Obx(() {
                            final list = controller.filteredPurchases;
                            if (controller.isLoadingPurchases.value) {
                              return const Center(
                                child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)),
                              );
                            }
                            if (list.isEmpty) {
                              return _buildEmptyState();
                            }
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
                              itemCount: list.length,
                              separatorBuilder: (context, index) => const Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(0xFFF1F5F9),
                              ),
                              itemBuilder: (context, index) {
                                final purchase = list[index];
                                return _buildTableRow(context, purchase, index + 1);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(AppColors.PRIMARY).withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: Color(AppColors.PRIMARY),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Purchases Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(AppColors.TEXTPRIMARY),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Record a new purchase to see supplier invoice and items history.',
            style: TextStyle(
              fontSize: 14,
              color: Color(AppColors.TEXTSECONDARY),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('NO', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 2, child: Text('Date', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 2, child: Text('Invoice No', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 3, child: Text('Supplier', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 2, child: Text('Payment Status', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 2, child: Text('Total', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 2, child: Text('Paid', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 2, child: Text('Due', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle)),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerRight, child: Text('Action', maxLines: 1, overflow: TextOverflow.ellipsis, style: _headerStyle))),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Purchase p, int index) {
    final dueColor = p.dueAmount == 0
        ? const Color(AppColors.TEXTSECONDARY)
        : (p.dueAmount < p.totalAmount ? const Color(0xFFD97706) : const Color(0xFFDC2626));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              index.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(fontSize: 11.5, color: const Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              PurchaseDialogs.formatDate(p.date),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(fontSize: 11.5, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              p.invoiceNo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(fontSize: 12, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              controller.getSupplierName(p),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(fontSize: 11.5, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildPaymentStatusBadge(p.paymentStatus),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              PurchaseDialogs.formatCurrency(p.totalAmount),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(fontSize: 12, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildPaidAmountPill(p.paidAmount, onEdit: () => PurchaseDialogs.showEditPaymentDialog(context, p)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              PurchaseDialogs.formatCurrency(p.dueAmount),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(fontSize: 12, color: dueColor, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: _buildViewButton(onTap: () => PurchaseDialogs.showPurchaseDetailsModal(context, p)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStatusBadge(String status) => PurchaseDialogs._buildPaymentStatusBadge(status);

  Widget _buildPaidAmountPill(int paid, {required VoidCallback onEdit}) {
    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                PurchaseDialogs.formatCurrency(paid),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(AppColors.TEXTPRIMARY),
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.edit_outlined, size: 13, color: Color(AppColors.TEXTSECONDARY)),
          ],
        ),
      ),
    );
  }

  Widget _buildViewButton({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.remove_red_eye_outlined, color: Color(AppColors.PRIMARY), size: 14),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'View',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(AppColors.PRIMARY),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseDialogs {
  static String formatDate(DateTime date) => _formatDate(date);
  static String formatCurrency(int amount) => _formatCurrency(amount);
  static Widget buildPaymentStatusBadge(String status) => _buildPaymentStatusBadge(status);

  static Widget _buildPaymentStatusBadge(String status) {
    Color textColor;
    Color bgColor;
    Color borderColor;
    IconData icon;
    switch (status.toLowerCase()) {
      case 'paid':
        textColor = const Color(0xFF16A34A);
        bgColor = const Color(0xFFDCFCE7);
        borderColor = const Color(0xFF86EFAC);
        icon = Icons.check_circle_outline;
        break;
      case 'partial':
      case 'partially paid':
      case 'partially_paid':
        textColor = const Color(0xFFD97706);
        bgColor = const Color(0xFFFEF3C7);
        borderColor = const Color(0xFFFDE68A);
        icon = Icons.pause_circle_outline;
        break;
      default:
        textColor = const Color(0xFFDC2626);
        bgColor = const Color(0xFFFEE2E2);
        borderColor = const Color(0xFFFCA5A5);
        icon = Icons.cancel_outlined;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 13),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              status,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  static String _formatCurrency(int amount) {
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

  // ---------------------------------------------------------------------------
  // 1. ADD PURCHASE MODAL - "INDIGO / VIOLET PURCHASE STUDIO" DESIGN
  // ---------------------------------------------------------------------------
  static void showAddPurchaseDialog(BuildContext context) {
    final controller = Get.find<PurchaseController>();
    controller.fetchPurchases();
    final invoiceNo = controller.generateInvoiceNumber();
    int? selectedSupplierId;
    DateTime selectedDate = DateTime.now();
    final itemRows = <_PurchaseItemFormRow>[_PurchaseItemFormRow()];
    final paidCtrl = TextEditingController();
    const accentColor = Color(0xFF4F46E5); // Deep Violet / Indigo

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            final isPhone = ResponsiveUtils.isPhone(context);

            int totalAmount = 0;
            for (final r in itemRows) {
              if (r.productId != null) {
                totalAmount += (r.unitPrice * r.quantity);
              }
            }
            int paidAmount = int.tryParse(paidCtrl.text.trim()) ?? 0;
            if (paidAmount > totalAmount) paidAmount = totalAmount;
            int dueAmount = totalAmount - paidAmount;

            String derivedStatus = 'Unpaid';
            if (paidAmount >= totalAmount && totalAmount > 0) {
              derivedStatus = 'Paid';
            } else if (paidAmount > 0) {
              derivedStatus = 'Partially Paid';
            }

            return _buildResponsivePurchaseDialogShell(
              context: context,
              accentColor: accentColor,
              maxWidth: 900,
              header: _buildPurchaseDialogHeader(
                accentColor: accentColor,
                badgeText: 'NEW INVOICE RECEIPT • STOCK ENTRY',
                title: 'New Supplier Purchase',
                subtitle: 'Select vendor partner, invoice date, and purchased items to restock inventory.',
                trailingBadge: invoiceNo,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Form Card: Supplier & Date
                  Container(
                    padding: EdgeInsets.all(isPhone ? 14 : 20),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accentColor.withValues(alpha: 0.18)),
                    ),
                    child: isPhone
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Select Supplier', style: _labelStyle),
                              const SizedBox(height: 8),
                              SaaSDropdownFormField.build<int>(
                                value: selectedSupplierId,
                                decoration: _inputDecoration('Choose registered supplier'),
                                items: controller.suppliers.map((s) {
                                  return DropdownMenuItem<int>(
                                    value: s.id,
                                    child: Text(
                                      s.name,
                                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY)),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setStateModal(() => selectedSupplierId = val);
                                },
                              ),
                              const SizedBox(height: 16),
                              Text('Invoice Date', style: _labelStyle),
                              const SizedBox(height: 8),
                              _buildDatePickerField(
                                context: context,
                                selectedDate: selectedDate,
                                onPicked: (picked) => setStateModal(() => selectedDate = picked),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Select Supplier', style: _labelStyle),
                                    const SizedBox(height: 8),
                                    SaaSDropdownFormField.build<int>(
                                      value: selectedSupplierId,
                                      decoration: _inputDecoration('Choose registered supplier'),
                                      items: controller.suppliers.map((s) {
                                        return DropdownMenuItem<int>(
                                          value: s.id,
                                          child: Text(
                                            s.name,
                                            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY)),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setStateModal(() => selectedSupplierId = val);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Invoice Date', style: _labelStyle),
                                    const SizedBox(height: 8),
                                    _buildDatePickerField(
                                      context: context,
                                      selectedDate: selectedDate,
                                      onPicked: (picked) => setStateModal(() => selectedDate = picked),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 24),

                  // Products List Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Purchased Products (${itemRows.length} item${itemRows.length == 1 ? "" : "s"})',
                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(AppColors.TEXTPRIMARY)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          setStateModal(() {
                            itemRows.add(_PurchaseItemFormRow());
                          });
                        },
                        style: TextButton.styleFrom(foregroundColor: accentColor),
                        icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                        label: Text('Add Product Row', style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Products List (Responsive Cards)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemRows.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final row = itemRows[index];
                      return Container(
                        key: ValueKey(row.id),
                        padding: EdgeInsets.all(isPhone ? 12 : 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: isPhone
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Dropdown
                                  SaaSDropdownFormField.build<int>(
                                    value: row.productId,
                                    decoration: _inputDecoration('Select available product'),
                                    items: controller.products.map((prod) {
                                      final brand = controller.getBrandName(prod);
                                      return DropdownMenuItem<int>(
                                        value: prod.id,
                                        child: Text(
                                          '${prod.name} ($brand)',
                                          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(AppColors.TEXTPRIMARY)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setStateModal(() {
                                        row.productId = val;
                                        if (val != null) {
                                          final p = controller.products.firstWhere((p) => p.id == val);
                                          row.unitPrice = p.buyPrice;
                                        }
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                          controller: row.qtyCtrl,
                                          keyboardType: TextInputType.number,
                                          decoration: _inputDecoration('Qty'),
                                          onChanged: (val) {
                                            setStateModal(() {
                                              row.quantity = int.tryParse(val) ?? 1;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _formatCurrency(row.subtotal),
                                              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: const Color(AppColors.TEXTPRIMARY)),
                                            ),
                                            if (row.unitPrice > 0)
                                              Text(
                                                '@ ₹${row.unitPrice} each',
                                                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY)),
                                              ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: itemRows.length > 1
                                            ? () {
                                                setStateModal(() {
                                                  final removed = itemRows.removeAt(index);
                                                  removed.dispose();
                                                });
                                              }
                                            : null,
                                        icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: SaaSDropdownFormField.build<int>(
                                      value: row.productId,
                                      decoration: _inputDecoration('Select available product'),
                                      items: controller.products.map((prod) {
                                        final brand = controller.getBrandName(prod);
                                        final category = controller.getCategoryName(prod);
                                        return DropdownMenuItem<int>(
                                          value: prod.id,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  prod.name,
                                                  style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w700, color: const Color(AppColors.TEXTPRIMARY)),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  brand,
                                                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(AppColors.PRIMARY)),
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF64748B).withValues(alpha: 0.12),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  category,
                                                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: prod.quantity > 0
                                                      ? const Color(0xFF16A34A).withValues(alpha: 0.12)
                                                      : const Color(0xFFDC2626).withValues(alpha: 0.12),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  '${prod.quantity}',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w800,
                                                    color: prod.quantity > 0 ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        setStateModal(() {
                                          row.productId = val;
                                          if (val != null) {
                                            final p = controller.products.firstWhere((p) => p.id == val);
                                            row.unitPrice = p.buyPrice;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: row.qtyCtrl,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration('Qty'),
                                      onChanged: (val) {
                                        setStateModal(() {
                                          row.quantity = int.tryParse(val) ?? 1;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _formatCurrency(row.subtotal),
                                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: const Color(AppColors.TEXTPRIMARY)),
                                        ),
                                        if (row.unitPrice > 0)
                                          Text(
                                            '@ ₹${row.unitPrice} each',
                                            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTSECONDARY)),
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: itemRows.length > 1
                                        ? () {
                                            setStateModal(() {
                                              final removed = itemRows.removeAt(index);
                                              removed.dispose();
                                            });
                                          }
                                        : null,
                                    icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 20),
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Financial Payment Summary Card (Responsive Grid on Phone)
                  Container(
                    padding: EdgeInsets.all(isPhone ? 14 : 18),
                    decoration: BoxDecoration(
                      color: const Color(AppColors.WHITE),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: accentColor.withValues(alpha: 0.25)),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: isPhone
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildSummaryMetric(
                                      title: 'Total Amount',
                                      value: _formatCurrency(totalAmount),
                                      valueColor: const Color(AppColors.TEXTPRIMARY),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: _buildSummaryMetric(
                                      title: 'Remaining Due',
                                      value: _formatCurrency(dueAmount),
                                      valueColor: dueAmount > 0 ? const Color(0xFFDC2626) : const Color(0xFF16A34A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Paid Amount (₹)', style: GoogleFonts.inter(fontSize: 11.5, color: const Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 6),
                                        TextField(
                                          controller: paidCtrl,
                                          keyboardType: TextInputType.number,
                                          decoration: _inputDecoration('Paid'),
                                          onChanged: (_) => setStateModal(() {}),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Payment Status', style: GoogleFonts.inter(fontSize: 11.5, color: const Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 8),
                                        _buildPaymentStatusBadge(derivedStatus),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: _buildSummaryMetric(
                                  title: 'Total Amount',
                                  value: _formatCurrency(totalAmount),
                                  valueColor: const Color(AppColors.TEXTPRIMARY),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Paid Amount (₹)', style: GoogleFonts.inter(fontSize: 12, color: const Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    TextField(
                                      controller: paidCtrl,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration('Paid'),
                                      onChanged: (_) => setStateModal(() {}),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 3,
                                child: _buildSummaryMetric(
                                  title: 'Remaining Due',
                                  value: _formatCurrency(dueAmount),
                                  valueColor: dueAmount > 0 ? const Color(0xFFDC2626) : const Color(0xFF16A34A),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Payment Status', style: GoogleFonts.inter(fontSize: 12, color: const Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 6),
                                    _buildPaymentStatusBadge(derivedStatus),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
              footer: _buildPurchaseDialogFooter(
                accentColor: accentColor,
                saveLabel: 'Create Purchase Invoice',
                onSave: () {
                  if (selectedSupplierId == null) {
                    AppNotification.warning('Missing Supplier', 'Please select a supplier from the list.');
                    return;
                  }

                  final validItems = <PurchaseItem>[];
                  for (final r in itemRows) {
                    if (r.productId != null && r.quantity > 0) {
                      validItems.add(
                        PurchaseItem(
                          purchaseId: 0,
                          productId: r.productId!,
                          quantity: r.quantity,
                          unitPrice: r.unitPrice,
                        ),
                      );
                    }
                  }

                  if (validItems.isEmpty) {
                    AppNotification.warning('No Items', 'Please select at least one product with a valid quantity.');
                    return;
                  }

                  final newPurchase = Purchase(
                    invoiceNo: invoiceNo,
                    supplierId: selectedSupplierId!,
                    date: selectedDate,
                    totalAmount: totalAmount,
                    paidAmount: paidAmount,
                    dueAmount: dueAmount,
                    paymentStatus: derivedStatus,
                  );

                  controller.createNewPurchase(
                    purchase: newPurchase,
                    items: validItems,
                  );
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 2. EDIT PAYMENT MODAL - "EMERALD / TEAL FINANCIAL SETTLEMENT SHEET" DESIGN
  // ---------------------------------------------------------------------------
  static void showEditPaymentDialog(BuildContext context, Purchase purchase) {
    final controller = Get.find<PurchaseController>();
    final paidCtrl = TextEditingController(text: '');
    const accentColor = Color(0xFF059669); // Professional Emerald Green

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
            final isPhone = ResponsiveUtils.isPhone(context);

            int addedAmount = int.tryParse(paidCtrl.text.trim()) ?? 0;
            if (addedAmount < 0) addedAmount = 0;
            int newPaid = purchase.paidAmount + addedAmount;
            if (newPaid > purchase.totalAmount) newPaid = purchase.totalAmount;
            final dueAmount = purchase.totalAmount - newPaid;

            String status = 'Unpaid';
            if (dueAmount <= 0 && purchase.totalAmount > 0) {
              status = 'Paid';
            } else if (newPaid > 0) {
              status = 'Partially Paid';
            }

            return _buildResponsivePurchaseDialogShell(
              context: context,
              accentColor: accentColor,
              maxWidth: 540,
              header: _buildPurchaseDialogHeader(
                accentColor: accentColor,
                badgeText: 'FINANCIAL LEDGER • PAYMENT UPDATE',
                title: 'Settlement: Invoice #${purchase.invoiceNo}',
                subtitle: 'Record additional vendor payment and update invoice settlement status.',
                trailingBadge: purchase.paymentStatus,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emerald Ledger Hero Card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentColor.withValues(alpha: 0.12),
                          accentColor.withValues(alpha: 0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildSummaryMetric(
                                title: 'Total Invoice Value',
                                value: _formatCurrency(purchase.totalAmount),
                                valueColor: accentColor,
                              ),
                            ),
                            Container(width: 1, height: 40, color: accentColor.withValues(alpha: 0.2)),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildSummaryMetric(
                                title: 'Previously Settled',
                                value: _formatCurrency(purchase.paidAmount),
                                valueColor: const Color(AppColors.TEXTPRIMARY),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: accentColor.withValues(alpha: 0.25)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Current Unpaid Balance',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: const Color(AppColors.TEXTPRIMARY)),
                              ),
                              Text(
                                _formatCurrency(purchase.totalAmount - purchase.paidAmount),
                                style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15, color: const Color(0xFFDC2626)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Add Payment Amount Field
                  Text(
                    'Add Payment Amount (₹)',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: const Color(AppColors.TEXTPRIMARY)),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: paidCtrl,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: _inputDecoration('Enter amount paid (e.g. 15000)').copyWith(
                      prefixIcon: Icon(Icons.payments_rounded, color: accentColor, size: 20),
                    ),
                    onChanged: (_) => setStateModal(() {}),
                  ),
                  const SizedBox(height: 22),

                  // Live Post-Payment Preview Pill
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NEW SETTLEMENT PREVIEW',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 0.8, color: const Color(AppColors.TEXTSECONDARY)),
                        ),
                        const SizedBox(height: 10),
                        isPhone
                            ? Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('New Paid Total:', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                                      Text(_formatCurrency(newPaid), style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: accentColor)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Remaining Due:', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                                      Text(_formatCurrency(dueAmount), style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: dueAmount > 0 ? const Color(0xFFDC2626) : const Color(0xFF16A34A))),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: _buildPaymentStatusBadge(status),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('New Paid Total', style: GoogleFonts.inter(fontSize: 11, color: const Color(AppColors.TEXTSECONDARY))),
                                      Text(_formatCurrency(newPaid), style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: accentColor)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Remaining Due', style: GoogleFonts.inter(fontSize: 11, color: const Color(AppColors.TEXTSECONDARY))),
                                      Text(_formatCurrency(dueAmount), style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: dueAmount > 0 ? const Color(0xFFDC2626) : const Color(0xFF16A34A))),
                                    ],
                                  ),
                                  _buildPaymentStatusBadge(status),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              footer: _buildPurchaseDialogFooter(
                accentColor: accentColor,
                saveLabel: 'Save Payment Entry',
                onSave: () {
                  if (addedAmount <= 0) {
                    AppNotification.warning('Invalid Amount', 'Please enter a payment amount greater than 0');
                    return;
                  }
                  final updatedPurchase = Purchase(
                    id: purchase.id,
                    invoiceNo: purchase.invoiceNo,
                    date: purchase.date,
                    supplierId: purchase.supplierId,
                    totalAmount: purchase.totalAmount,
                    paidAmount: newPaid,
                    dueAmount: dueAmount,
                    paymentStatus: status,
                  );
                  controller.updatePurchasePayment(updatedPurchase);
                  Navigator.pop(context);
                },
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 3. VIEW DETAILS MODAL - RESPONSIVE LEDGER CARD DESIGN
  // ---------------------------------------------------------------------------
  static void showPurchaseDetailsModal(BuildContext context, Purchase purchase) {
    final controller = Get.find<PurchaseController>();
    const accentColor = Color(0xFF2563EB); // Royal Blue Ledger

    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<List<PurchaseItem>>(
          future: controller.fetchItemsForPurchase(purchase.id!),
          builder: (context, snapshot) {
            final items = snapshot.data ?? [];
            final isLoading = snapshot.connectionState == ConnectionState.waiting;
            final isPhone = ResponsiveUtils.isPhone(context);

            return _buildResponsivePurchaseDialogShell(
              context: context,
              accentColor: accentColor,
              maxWidth: 720,
              header: _buildPurchaseDialogHeader(
                accentColor: accentColor,
                badgeText: 'INVOICE BREAKDOWN • FULL DETAILS',
                title: 'Purchase Details: ${purchase.invoiceNo}',
                subtitle: 'Complete product list and financial settlement breakdown.',
                trailingBadge: purchase.paymentStatus,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Invoice Metadata Banner
                  Container(
                    padding: EdgeInsets.all(isPhone ? 14 : 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: isPhone
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSummaryMetric(
                                title: 'Supplier Partner',
                                value: controller.getSupplierName(purchase),
                                valueColor: const Color(AppColors.TEXTPRIMARY),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildSummaryMetric(
                                      title: 'Invoice Date',
                                      value: _formatDate(purchase.date),
                                      valueColor: const Color(AppColors.TEXTPRIMARY),
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildSummaryMetric(
                                      title: 'Total Amount',
                                      value: _formatCurrency(purchase.totalAmount),
                                      valueColor: accentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSummaryMetric(
                                title: 'Supplier Partner',
                                value: controller.getSupplierName(purchase),
                                valueColor: const Color(AppColors.TEXTPRIMARY),
                              ),
                              _buildSummaryMetric(
                                title: 'Invoice Date',
                                value: _formatDate(purchase.date),
                                valueColor: const Color(AppColors.TEXTPRIMARY),
                              ),
                              _buildSummaryMetric(
                                title: 'Total Amount',
                                value: _formatCurrency(purchase.totalAmount),
                                valueColor: accentColor,
                              ),
                              _buildSummaryMetric(
                                title: 'Amount Paid',
                                value: _formatCurrency(purchase.paidAmount),
                                valueColor: const Color(0xFF16A34A),
                              ),
                            ],
                          ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Purchased Line Items',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: const Color(AppColors.TEXTPRIMARY)),
                  ),
                  const SizedBox(height: 10),

                  if (isLoading)
                    const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
                  else if (items.isEmpty)
                    const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No items found for this purchase invoice.')))
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final product = controller.products.cast<Product?>().firstWhere(
                              (p) => p?.id == item.productId,
                              orElse: () => null,
                            );
                        final productName = product?.name ?? 'Unknown Product (ID: ${item.productId})';
                        final brandName = product != null ? controller.getBrandName(product) : '';
                        final categoryName = product != null ? controller.getCategoryName(product) : '';

                        return Container(
                          padding: EdgeInsets.all(isPhone ? 12 : 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: isPhone
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(productName, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: const Color(AppColors.TEXTPRIMARY))),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${item.quantity} units @ ₹${item.unitPrice}', style: GoogleFonts.inter(fontSize: 12, color: const Color(AppColors.TEXTSECONDARY))),
                                        Text(_formatCurrency(item.quantity * item.unitPrice), style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: const Color(AppColors.TEXTPRIMARY))),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(productName, style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13.5, color: const Color(AppColors.TEXTPRIMARY))),
                                          if (brandName.isNotEmpty) ...[
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: accentColor.withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(brandName, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: accentColor)),
                                                ),
                                                const SizedBox(width: 6),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF64748B).withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(categoryName, style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text('${item.quantity} units', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text('₹${item.unitPrice} / unit', style: GoogleFonts.inter(color: const Color(AppColors.TEXTSECONDARY), fontSize: 13)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          _formatCurrency(item.quantity * item.unitPrice),
                                          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: const Color(AppColors.TEXTPRIMARY)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                ],
              ),
              footer: Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC).withValues(alpha: 0.8),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Close Breakdown', style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // SHARED RESPONSIVE DIALOG SHELL & FORM HELPERS (ZERO OVERFLOW & KEYBOARD SAFE)
  // ---------------------------------------------------------------------------
  static Widget _buildResponsivePurchaseDialogShell({
    required BuildContext context,
    required Color accentColor,
    required Widget header,
    required Widget content,
    required Widget footer,
    double maxWidth = 880,
  }) {
    final isPhone = ResponsiveUtils.isPhone(context);
    final maxH = MediaQuery.of(context).size.height * (isPhone ? 0.92 : 0.88);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isPhone ? 12 : 32,
        vertical: 16,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: maxH,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(AppColors.WHITE),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: accentColor.withValues(alpha: 0.25), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 40,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header,
              Divider(height: 1, color: accentColor.withValues(alpha: 0.15)),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(isPhone ? 18 : 26),
                  child: content,
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              footer,
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildPurchaseDialogHeader({
    required Color accentColor,
    required String badgeText,
    required String title,
    required String subtitle,
    required String trailingBadge,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 20, 18),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.04),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: accentColor.withValues(alpha: 0.3)),
            ),
            child: Center(
              child: Icon(
                Icons.shopping_bag_rounded,
                color: accentColor,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badgeText,
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: accentColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        trailingBadge,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: const Color(AppColors.TEXTPRIMARY),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    color: const Color(AppColors.TEXTSECONDARY),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            tooltip: 'Close',
            icon: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.close_rounded,
                color: Color(AppColors.TEXTSECONDARY),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPurchaseDialogFooter({
    required Color accentColor,
    required String saveLabel,
    required VoidCallback onSave,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC).withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(AppColors.TEXTPRIMARY),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
            label: Text(
              saveLabel,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDatePickerField({
    required BuildContext context,
    required DateTime selectedDate,
    required Function(DateTime) onPicked,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await SaaSDatePicker.show(
          context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          onPicked(picked);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(AppColors.WHITE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(selectedDate),
              style: const TextStyle(fontSize: 14, color: Color(AppColors.TEXTPRIMARY)),
            ),
            const Icon(Icons.calendar_today_rounded, size: 18, color: Color(AppColors.TEXTSECONDARY)),
          ],
        ),
      ),
    );
  }

  static Widget _buildSummaryMetric({
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 11.5, color: const Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: valueColor),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}


final TextStyle _headerStyle = GoogleFonts.inter(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: const Color(AppColors.TEXTSECONDARY),
  letterSpacing: 0.5,
);

final TextStyle _labelStyle = GoogleFonts.inter(
  fontSize: 13,
  fontWeight: FontWeight.w600,
  color: const Color(AppColors.TEXTPRIMARY),
);

InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(AppColors.HINTTEXT)),
    filled: true,
    fillColor: const Color(AppColors.WHITE),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(AppColors.PRIMARY), width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
}
