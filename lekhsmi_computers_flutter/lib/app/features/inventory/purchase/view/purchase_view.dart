import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_dropdown.dart';
import 'package:lekhsmi_computers_flutter/app/features/inventory/purchase/controller/purchase_controller.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Purchases & Stock History',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(AppColors.TEXTPRIMARY),
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
                  'INVENTORY RECORDS',
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
          Row(
            children: [
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
                      _formatDate(DateTime.now()),
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
                    onPressed: () => _showAddPurchaseDialog(context),
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
                final double minWidth = 960.0;
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
                        const SizedBox(height: 8),
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text('NO', style: _headerStyle)),
          Expanded(flex: 2, child: Text('Date', style: _headerStyle)),
          Expanded(flex: 2, child: Text('Invoice No', style: _headerStyle)),
          Expanded(flex: 2, child: Text('Supplier', style: _headerStyle)),
          Expanded(flex: 2, child: Text('Payment Status', style: _headerStyle)),
          Expanded(flex: 2, child: Text('Total', style: _headerStyle)),
          Expanded(flex: 2, child: Text('Paid', style: _headerStyle)),
          Expanded(flex: 2, child: Text('Due', style: _headerStyle)),
          Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text('Action', style: _headerStyle))),
        ],
      ),
    );
  }

  Widget _buildTableRow(BuildContext context, Purchase p, int index) {
    final dueColor = p.dueAmount == 0
        ? const Color(AppColors.TEXTSECONDARY)
        : (p.dueAmount < p.totalAmount ? const Color(0xFFD97706) : const Color(0xFFDC2626));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              index.toString(),
              style: GoogleFonts.inter(fontSize: 13, color: const Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(p.date),
              style: GoogleFonts.inter(fontSize: 13, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              p.invoiceNo,
              style: GoogleFonts.inter(fontSize: 13.5, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              controller.getSupplierName(p),
              style: GoogleFonts.inter(fontSize: 13, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w600),
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
              _formatCurrency(p.totalAmount),
              style: GoogleFonts.inter(fontSize: 13.5, color: const Color(AppColors.TEXTPRIMARY), fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildPaidAmountPill(p.paidAmount, onEdit: () => _showEditPaymentDialog(context, p)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatCurrency(p.dueAmount),
              style: GoogleFonts.inter(fontSize: 13.5, color: dueColor, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: _buildViewButton(onTap: () => _showPurchaseDetailsModal(context, p)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStatusBadge(String status) {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 14),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPaidAmountPill(int paid, {required VoidCallback onEdit}) {
    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _formatCurrency(paid),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(AppColors.TEXTPRIMARY),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.edit_outlined, size: 14, color: Color(AppColors.TEXTSECONDARY)),
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.remove_red_eye_outlined, color: Color(AppColors.PRIMARY), size: 16),
            SizedBox(width: 6),
            Text(
              'View',
              style: TextStyle(
                color: Color(AppColors.PRIMARY),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year.toString();
    return '$day/$month/$year';
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

  // --- ADD PURCHASE MODAL ---
  void _showAddPurchaseDialog(BuildContext context) {
    controller.fetchPurchases();
    final invoiceNo = controller.generateInvoiceNumber();
    int? selectedSupplierId;
    DateTime selectedDate = DateTime.now();
    final itemRows = <_PurchaseItemFormRow>[_PurchaseItemFormRow()];
    final paidCtrl = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
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

            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 900,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.95,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(AppColors.WHITE),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Modal Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Add New Purchase',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(AppColors.TEXTPRIMARY),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                invoiceNo,
                                style: const TextStyle(
                                  color: Color(AppColors.PRIMARY),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded, color: Color(AppColors.TEXTSECONDARY)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Record supplier purchase invoice. Adding items will automatically update product stock upon submission.',
                      style: TextStyle(fontSize: 13, color: Color(AppColors.TEXTSECONDARY)),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFE2E8F0), height: 1),
                    const SizedBox(height: 20),

                    // Top Form: Supplier & Date
                    Row(
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
                                    child: Text(s.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(AppColors.TEXTPRIMARY))),
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
                              InkWell(
                                onTap: () async {
                                  final picked = await SaaSDatePicker.show(
                                    context,
                                    initialDate: selectedDate,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2030),
                                  );
                                  if (picked != null) {
                                    setStateModal(() => selectedDate = picked);
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Products List Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Purchased Products (No Brand/Category restriction)',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            setStateModal(() {
                              itemRows.add(_PurchaseItemFormRow());
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline, size: 18),
                          label: const Text('Add Product Item', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Products List View
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: itemRows.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final row = itemRows[index];
                            return Row(
                              key: ValueKey(row.id),
                              children: [
                                // Product dropdown (Input #1)
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
                                // Quantity input (Input #2)
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
                                // Subtotal & Unit price display (Buy Price input removed)
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
                                // Delete row button
                                IconButton(
                                  onPressed: itemRows.length > 1
                                      ? () {
                                          setStateModal(() {
                                            final removed = itemRows.removeAt(index);
                                            removed.dispose();
                                          });
                                        }
                                      : null,
                                  icon: const Icon(Icons.delete_outline, color: Color(0xFFDC2626), size: 20),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Financial & Payment Summary Bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(AppColors.WHITE),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Amount', style: TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
                                const SizedBox(height: 4),
                                Text(
                                  _formatCurrency(totalAmount),
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Paid Amount (₹)', style: TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Remaining Due', style: TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
                                const SizedBox(height: 4),
                                Text(
                                  _formatCurrency(dueAmount),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: dueAmount > 0 ? const Color(0xFFDC2626) : const Color(0xFF16A34A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('Payment Status', style: TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY))),
                                const SizedBox(height: 4),
                                _buildPaymentStatusBadge(derivedStatus),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel', style: TextStyle(color: Color(AppColors.TEXTSECONDARY))),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (selectedSupplierId == null) {
                              Get.snackbar('Error', 'Please select a supplier');
                              return;
                            }
                            final validRows = itemRows.where((r) => r.productId != null).toList();
                            if (validRows.isEmpty) {
                              Get.snackbar('Error', 'Please add at least 1 valid product item');
                              return;
                            }

                            final purchase = Purchase(
                              invoiceNo: invoiceNo,
                              date: selectedDate,
                              supplierId: selectedSupplierId!,
                              totalAmount: totalAmount,
                              paidAmount: paidAmount,
                              dueAmount: dueAmount,
                              paymentStatus: derivedStatus,
                            );

                            final pItems = validRows.map((r) {
                              return PurchaseItem(
                                purchaseId: 0,
                                productId: r.productId!,
                                quantity: r.quantity,
                                unitPrice: r.unitPrice,
                              );
                            }).toList();

                            final success = await controller.createNewPurchase(
                              purchase: purchase,
                              items: pItems,
                            );

                            if (success && context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
                          label: const Text(
                            'Record Purchase & Update Stock',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(AppColors.PRIMARY),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
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

  // --- EDIT PAYMENT MODAL ---
  void _showEditPaymentDialog(BuildContext context, Purchase purchase) {
    final paidCtrl = TextEditingController(text: '');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateModal) {
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

            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 440,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: const Color(AppColors.WHITE),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Update Payment - ${purchase.invoiceNo}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount: ${_formatCurrency(purchase.totalAmount)}', style: _labelStyle),
                        Text('Previously Paid: ${_formatCurrency(purchase.paidAmount)}', style: _labelStyle),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Add New Payment Amount (₹)', style: _labelStyle),
                    const SizedBox(height: 8),
                    TextField(
                      controller: paidCtrl,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('Enter amount to add'),
                      onChanged: (_) => setStateModal(() {}),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('New Total Paid: ${_formatCurrency(newPaid)}', style: const TextStyle(fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY))),
                        Text('Remaining Due: ${_formatCurrency(dueAmount)}', style: const TextStyle(fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildPaymentStatusBadge(status),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () async {
                            purchase.paidAmount = newPaid;
                            purchase.dueAmount = dueAmount;
                            purchase.paymentStatus = status;
                            await controller.updatePurchasePayment(purchase);
                            if (context.mounted) Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(AppColors.PRIMARY),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Save Changes'),
                        ),
                      ],
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

  // --- VIEW DETAILS MODAL ---
  void _showPurchaseDetailsModal(BuildContext context, Purchase purchase) {
    showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder<List<PurchaseItem>>(
          future: controller.fetchItemsForPurchase(purchase.id!),
          builder: (context, snapshot) {
            final items = snapshot.data ?? [];
            final isLoading = snapshot.connectionState == ConnectionState.waiting;

            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 700,
                constraints: const BoxConstraints(maxHeight: 680),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(AppColors.WHITE),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  purchase.invoiceNo,
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(AppColors.TEXTPRIMARY)),
                                ),
                                const SizedBox(width: 12),
                                _buildPaymentStatusBadge(purchase.paymentStatus),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Supplier: ${controller.getSupplierName(purchase)}  |  Date: ${_formatDate(purchase.date)}',
                              style: const TextStyle(fontSize: 14, color: Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded, color: Color(AppColors.TEXTSECONDARY)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFE2E8F0), height: 1),
                    const SizedBox(height: 20),

                    // Cards Summary
                    Row(
                      children: [
                        Expanded(
                          child: _buildSummaryCard('Total Invoice', _formatCurrency(purchase.totalAmount), const Color(AppColors.PRIMARY)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard('Paid Amount', _formatCurrency(purchase.paidAmount), const Color(0xFF16A34A)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSummaryCard('Remaining Due', _formatCurrency(purchase.dueAmount), const Color(0xFFDC2626)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Products Purchased in this Invoice',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(AppColors.TEXTPRIMARY)),
                    ),
                    const SizedBox(height: 12),

                    // Table of Items
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator(color: Color(AppColors.PRIMARY)))
                            : items.isEmpty
                                ? const Center(child: Text('No item rows found for this purchase.'))
                                : ListView.separated(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: items.length,
                                    separatorBuilder: (context, index) => const Divider(height: 20, color: Color(0xFFE2E8F0)),
                                    itemBuilder: (context, index) {
                                      final item = items[index];
                                      final found = controller.products.firstWhere(
                                        (p) => p.id == item.productId,
                                        orElse: () => Product(name: item.product?.name ?? 'Product #${item.productId}', categoryId: 0, brandId: 0, quality: '', quantity: 0, buyPrice: 0, sellPrice: 0, status: true),
                                      );
                                      final brandName = controller.getBrandName(found);
                                      final categoryName = controller.getCategoryName(found);
                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text('${index + 1}', style: const TextStyle(color: Color(AppColors.TEXTSECONDARY))),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  found.name,
                                                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(AppColors.TEXTPRIMARY)),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: const Color(AppColors.PRIMARY).withValues(alpha: 0.1),
                                                        borderRadius: BorderRadius.circular(6),
                                                      ),
                                                      child: Text(
                                                        brandName,
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
                                                        categoryName,
                                                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: const Color(0xFF334155)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text('Qty: ${item.quantity}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text('₹${item.unitPrice} / unit', style: const TextStyle(color: Color(AppColors.TEXTSECONDARY))),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                _formatCurrency(item.quantity * item.unitPrice),
                                                style: const TextStyle(fontWeight: FontWeight.w800, color: Color(AppColors.TEXTPRIMARY)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(AppColors.PRIMARY),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Close Details'),
                        ),
                      ],
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

  Widget _buildSummaryCard(String title, String amount, Color accentColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(AppColors.WHITE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Color(AppColors.TEXTSECONDARY), fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(amount, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: accentColor)),
        ],
      ),
    );
  }
}

final TextStyle _headerStyle = GoogleFonts.inter(
  fontSize: 12,
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
