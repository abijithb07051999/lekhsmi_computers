import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class QuotationItem {
  final String productName;
  final int quantity;
  final double price;

  QuotationItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });

  double get amount => quantity * price;
}

class QuotationController extends GetxController {
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final customerName = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final address = ''.obs;

  final currentDate = DateTime.now().obs;
  final validUptoDate = DateTime.now().obs;

  // Item Input Controllers
  final itemProductController = TextEditingController();
  final itemQuantityController = TextEditingController(text: '1');
  final itemPriceController = TextEditingController();

  final items = <QuotationItem>[].obs;

  // GST Toggle & Percentage
  final isGstEnabled = false.obs;
  final gstPercentageController = TextEditingController(text: '18');
  final gstPercentage = 18.0.obs;

  @override
  void onInit() {
    super.onInit();
    customerNameController.addListener(() => customerName.value = customerNameController.text);
    phoneController.addListener(() => phone.value = phoneController.text);
    emailController.addListener(() => email.value = emailController.text);
    addressController.addListener(() => address.value = addressController.text);
    gstPercentageController.addListener(() {
      final val = double.tryParse(gstPercentageController.text);
      if (val != null) {
        gstPercentage.value = val;
      } else {
        gstPercentage.value = 0.0;
      }
    });

    // Start with empty quotation form so user can type manually
  }

  void clearForm() {
    customerNameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    items.clear();
    itemProductController.clear();
    itemQuantityController.text = '1';
    itemPriceController.clear();
    isGstEnabled.value = false;
    gstPercentageController.text = '18';
    currentDate.value = DateTime.now();
    validUptoDate.value = DateTime.now().add(const Duration(days: 7));
  }

  void addItem() {
    final name = itemProductController.text.trim();
    final qty = int.tryParse(itemQuantityController.text.trim()) ?? 1;
    final price = double.tryParse(itemPriceController.text.trim());

    if (items.length >= 10) {
      Get.snackbar('Limit Reached', 'Maximum 10 products / services allowed per quotation to fit inside a single A4 sheet.',
          backgroundColor: const Color(0xFFFEF2F2), colorText: const Color(0xFFEF4444));
      return;
    }
    if (name.isEmpty) {
      Get.snackbar('Validation', 'Please enter a product name',
          backgroundColor: const Color(0xFFFEF2F2), colorText: const Color(0xFFEF4444));
      return;
    }
    if (price == null || price <= 0) {
      Get.snackbar('Validation', 'Please enter a valid price',
          backgroundColor: const Color(0xFFFEF2F2), colorText: const Color(0xFFEF4444));
      return;
    }
    if (qty <= 0) {
      Get.snackbar('Validation', 'Quantity must be at least 1',
          backgroundColor: const Color(0xFFFEF2F2), colorText: const Color(0xFFEF4444));
      return;
    }

    items.add(QuotationItem(
      productName: name,
      quantity: qty,
      price: price,
    ));

    itemProductController.clear();
    itemQuantityController.text = '1';
    itemPriceController.clear();
  }

  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  void toggleGst(bool value) {
    isGstEnabled.value = value;
  }

  double get subTotal => items.fold(0.0, (sum, item) => sum + item.amount);

  double get gstAmount => isGstEnabled.value ? (subTotal * (gstPercentage.value / 100.0)) : 0.0;

  double get totalAmount => subTotal + gstAmount;

  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  Future<void> selectValidUptoDate(BuildContext context) async {
    final picked = await SaaSDatePicker.show(
      context,
      initialDate: validUptoDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      validUptoDate.value = picked;
    }
  }

  @override
  void onClose() {
    customerNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    itemProductController.dispose();
    itemQuantityController.dispose();
    itemPriceController.dispose();
    gstPercentageController.dispose();
    super.onClose();
  }

  bool validateBeforePrint() {
    if (customerName.value.trim().isEmpty) {
      Get.snackbar(
        'Required Field Missing',
        'Please enter the Customer Name.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (phone.value.trim().isEmpty) {
      Get.snackbar(
        'Required Field Missing',
        'Please enter the Phone Number.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (address.value.trim().isEmpty) {
      Get.snackbar(
        'Required Field Missing',
        'Please enter the Address.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (items.isEmpty) {
      Get.snackbar(
        'No Products Added',
        'Please add at least one product to print the quotation.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  Future<void> printQuotationPdf() async {
    if (!validateBeforePrint()) {
      return;
    }
    final doc = pw.Document();
    final settings = Get.find<SettingsController>();

    final nameText = customerName.value.trim().isEmpty ? 'Customer Name' : customerName.value.trim();
    final phoneText = phone.value.trim();
    final emailText = email.value.trim();
    final addressText = address.value.trim();

    final dateStr = formatDate(currentDate.value);
    final validStr = formatDate(validUptoDate.value);

    final sub = subTotal;
    final isGst = isGstEnabled.value;
    final gstPct = gstPercentage.value;
    final gstAmt = gstAmount;
    final total = totalAmount;

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        footer: (pw.Context context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(thickness: 1, color: PdfColors.grey600),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Expanded(
                    flex: 7,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Terms & Conditions',
                            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                        pw.SizedBox(height: 4),
                        pw.Text('1. Goods once sold cannot be taken back.', style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey800)),
                        pw.SizedBox(height: 2),
                        pw.Text('2. No Warranty for Physical/Tampering (Incl. stickers).', style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey800)),
                        pw.SizedBox(height: 2),
                        pw.Text('3. Bill Copy Necessary for Claiming Warranty.', style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey800)),
                        pw.SizedBox(height: 2),
                        pw.Text('4. No Warranty for Software Installation.', style: const pw.TextStyle(fontSize: 8.5, color: PdfColors.grey800)),
                      ],
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.SizedBox(height: 30),
                      pw.Text('Authorized Signature',
                          style: pw.TextStyle(fontSize: 10.5, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
        build: (pw.Context context) {
          return [
            // 1. Header (Black & White)
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(settings.storeName.value,
                        style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                    pw.SizedBox(height: 2),
                    pw.Text('Sales   |   Service   |   Repair   |   Support',
                        style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                    pw.SizedBox(height: 12),
                    pw.Text('QUOTATION',
                        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Phone: ${settings.storePhone.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                    pw.SizedBox(height: 4),
                    pw.Text('Email: ${settings.storeEmail.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                    if (settings.storeWebsite.value.isNotEmpty) ...[
                      pw.SizedBox(height: 4),
                      pw.Text('Web: ${settings.storeWebsite.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                    ],
                    pw.SizedBox(height: 4),
                    pw.Text('Address: ${settings.storeAddress.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 16),
            pw.Divider(thickness: 1, color: PdfColors.black),
            pw.SizedBox(height: 16),

            // 2. Customer Details & Dates
            pw.Text('Customer Details',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(nameText, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                      if (phoneText.isNotEmpty) ...[
                        pw.SizedBox(height: 3),
                        pw.Text('Phone: $phoneText', style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey800)),
                      ],
                      if (addressText.isNotEmpty) ...[
                        pw.SizedBox(height: 3),
                        pw.Text('Address: $addressText', style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey800)),
                      ],
                      if (emailText.isNotEmpty) ...[
                        pw.SizedBox(height: 3),
                        pw.Text('Email: $emailText', style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey800)),
                      ],
                    ],
                  ),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Date :   $dateStr',
                        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                    pw.SizedBox(height: 4),
                    pw.Text('Valid upto :   $validStr',
                        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                  ],
                ),
              ],
            ),

            pw.SizedBox(height: 14),

            // 3. Products / Services Table (Max 10 items)
            pw.Container(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(color: PdfColors.black, width: 1.5),
                  top: pw.BorderSide(color: PdfColors.black, width: 1.5),
                ),
              ),
              padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: pw.Row(
                children: [
                  pw.SizedBox(
                    width: 40,
                    child: pw.Text('NO',
                        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                  ),
                  pw.Expanded(
                    child: pw.Text('Reason / Description',
                        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                  ),
                  pw.SizedBox(
                    width: 100,
                    child: pw.Text('Amount',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                  ),
                ],
              ),
            ),

            if (items.isEmpty)
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 24),
                child: pw.Center(
                  child: pw.Text('No items added', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
                ),
              )
            else
              for (int idx = 0; idx < items.length; idx++)
                pw.Container(
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.grey400, width: 0.5),
                    ),
                  ),
                  padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  child: pw.Row(
                    children: [
                      pw.SizedBox(
                        width: 40,
                        child: pw.Text('${idx + 1}',
                            style: const pw.TextStyle(fontSize: 11, color: PdfColors.black)),
                      ),
                      pw.Expanded(
                        child: pw.Text(
                          items[idx].quantity > 1
                              ? '${items[idx].productName} (${items[idx].quantity} x ${_formatPdfCurrency(items[idx].price)})'
                              : items[idx].productName,
                          maxLines: 1,
                          overflow: pw.TextOverflow.clip,
                          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
                        ),
                      ),
                      pw.SizedBox(
                        width: 100,
                        child: pw.Text(
                          _formatPdfCurrency(items[idx].amount, showSign: true),
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
                        ),
                      ),
                    ],
                  ),
                ),

            pw.SizedBox(height: 10),

            // 4. Totals (Right Aligned)
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.SizedBox(
                width: 250,
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Total',
                            style: pw.TextStyle(fontSize: 12, fontWeight: isGst ? pw.FontWeight.normal : pw.FontWeight.bold, color: PdfColors.black)),
                        pw.Text(_formatPdfCurrency(sub),
                            style: pw.TextStyle(fontSize: 12, fontWeight: isGst ? pw.FontWeight.normal : pw.FontWeight.bold, color: PdfColors.black)),
                      ],
                    ),
                    if (isGst) ...[
                      pw.SizedBox(height: 6),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('GST (${gstPct.toStringAsFixed(gstPct == gstPct.toInt() ? 0 : 1)}%)',
                              style: const pw.TextStyle(fontSize: 11, color: PdfColors.black)),
                          pw.Text(_formatPdfCurrency(gstAmt),
                              style: const pw.TextStyle(fontSize: 11, color: PdfColors.black)),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Divider(thickness: 1, color: PdfColors.black),
                      pw.SizedBox(height: 4),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Total Amount',
                              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                          pw.Text(_formatPdfCurrency(total),
                              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                        ],
                      ),
                    ] else ...[
                      pw.SizedBox(height: 6),
                      pw.Divider(thickness: 1, color: PdfColors.black),
                      pw.SizedBox(height: 4),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Total Amount',
                              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                          pw.Text(_formatPdfCurrency(total),
                              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
      name: 'Quotation_${customerName.value.trim().isEmpty ? "Customer" : customerName.value.trim()}',
    );

    clearForm();
  }

  String _formatPdfCurrency(double amount, {bool showSign = false}) {
    final intVal = amount.round();
    final str = intVal.abs().toString();
    String formatted = '';
    int len = str.length;
    if (len <= 3) {
      formatted = str;
    } else {
      formatted = str.substring(len - 3);
      int rem = len - 3;
      while (rem > 0) {
        if (rem >= 2) {
          formatted = '${str.substring(rem - 2, rem)},$formatted';
          rem -= 2;
        } else {
          formatted = '${str.substring(0, 1)},$formatted';
          rem -= 1;
        }
      }
    }
    if (intVal < 0) {
      formatted = '-$formatted';
    }
    if (showSign && intVal > 0) {
      return '+Rs. $formatted';
    }
    return 'Rs. $formatted';
  }
}
