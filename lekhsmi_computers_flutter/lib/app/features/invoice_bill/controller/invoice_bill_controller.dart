import 'package:flutter/material.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:get/get.dart';
import 'package:lekhsmi_computers_client/lekhsmi_computers_client.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/controller/settings_controller.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/saas_date_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:lekhsmi_computers_flutter/core/widgets/saas_print_modal.dart';
import 'package:printing/printing.dart';
import 'dart:math' as math;
import '../../inventory/product/controller/product_controller.dart';

class InvoiceBillItem {
  final String id;
  final int? productId;
  final String productName;
  final int quantity;
  final double price;

  InvoiceBillItem({
    required this.id,
    this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  double get amount => quantity * price;
}

class InvoiceBillController extends GetxController {
  final Client _client = Get.find<Client>();

  // Customer Form Controllers (No default values - manual entry)
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final customerName = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final address = ''.obs;

  // Dates
  final currentDate = DateTime.now().obs;
  final validUptoDate = DateTime.now().add(const Duration(days: 30)).obs;

  // GST Toggle & Percentage
  final isGstEnabled = false.obs;
  final gstPercentage = 18.0.obs;
  final gstInputController = TextEditingController();

  // Currently Added Invoice Items (Max 13 for A4 Sheet)
  final items = <InvoiceBillItem>[].obs;

  // Inventory Products & Selected Product
  final products = <Product>[].obs;
  final selectedProduct = Rxn<Product>();
  final isLoadingProducts = false.obs;

  // Item Form Controllers for Quantity & Price
  final itemQuantityController = TextEditingController();
  final itemPriceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() => customerName.value = nameController.text);
    phoneController.addListener(() => phone.value = phoneController.text);
    emailController.addListener(() => email.value = emailController.text);
    addressController.addListener(() => address.value = addressController.text);
    refreshProducts();
    gstInputController.text = '18';
  }

  Future<void> refreshProducts() async {
    try {
      isLoadingProducts.value = true;
      final results = await _client.product.getAllProducts();
      products.assignAll(results);
      if (selectedProduct.value != null) {
        final currentId = selectedProduct.value?.id;
        final matching = products.where((p) => p.id == currentId).firstOrNull;
        selectedProduct.value = matching;
      }
    } catch (e) {
      AppNotification.error('Error', 'Failed to load inventory products: $e');
    } finally {
      isLoadingProducts.value = false;
    }
  }

  void selectProduct(Product? product) {
    selectedProduct.value = product;
    if (product != null) {
      itemPriceController.text = product.sellPrice.toString();
      itemQuantityController.clear();
    } else {
      itemPriceController.clear();
      itemQuantityController.clear();
    }
  }

  void validateQuantityInput(String val) {
    final product = selectedProduct.value;
    if (product == null) return;

    if (product.quantity <= 0) {
      if (itemQuantityController.text != '0') {
        itemQuantityController.text = '0';
      }
      return;
    }

    final intVal = int.tryParse(val);
    if (intVal != null && intVal > product.quantity) {
      itemQuantityController.text = product.quantity.toString();
      itemQuantityController.selection = TextSelection.fromPosition(
        TextPosition(offset: itemQuantityController.text.length),
      );
      AppNotification.warning('Max Stock Limit', 'Maximum available stock for "${product.name}" is ${product.quantity}.');
    }
  }

  void toggleGst(bool val) {
    isGstEnabled.value = val;
  }

  void updateGstPercentage(String val) {
    final parsed = double.tryParse(val);
    if (parsed != null && parsed >= 0) {
      gstPercentage.value = parsed;
    }
  }

  void pickDate(BuildContext context, bool isCurrent) async {
    final initial = isCurrent ? currentDate.value : validUptoDate.value;
    final picked = await SaaSDatePicker.show(
      context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      if (isCurrent) {
        currentDate.value = picked;
      } else {
        validUptoDate.value = picked;
      }
    }
  }

  void addItem() {
    if (selectedProduct.value == null) {
      AppNotification.error('Product Required', 'Please select a product from the inventory list.');
      return;
    }

    if (items.length >= 13) {
      AppNotification.error('Limit Reached', 'A4 sheet printing supports a maximum of 13 products / services.');
      return;
    }

    final product = selectedProduct.value!;
    final quantity = int.tryParse(itemQuantityController.text.trim()) ?? 1;
    final price = double.tryParse(itemPriceController.text.trim()) ?? product.sellPrice.toDouble();

    if (quantity <= 0) {
      AppNotification.error('Invalid Quantity', 'Please enter a quantity greater than 0.');
      return;
    }

    if (quantity > product.quantity) {
      AppNotification.error('Insufficient Stock', 'Only ${product.quantity} items available in stock for "${product.name}".');
      return;
    }

    items.add(
      InvoiceBillItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        productId: product.id,
        productName: product.name,
        quantity: quantity,
        price: price,
      ),
    );

    // Clear selection for next item
    selectProduct(null);
  }

  void removeItem(String id) {
    items.removeWhere((element) => element.id == id);
  }

  double get subTotal => items.fold(0.0, (sum, item) => sum + item.amount);

  double get gstAmount {
    if (!isGstEnabled.value) return 0.0;
    return subTotal * (gstPercentage.value / 100.0);
  }

  double get totalAmount => subTotal + gstAmount;

  bool validateBeforePrint() {
    if (customerName.value.trim().isEmpty) {
      AppNotification.error('Required Field Missing', 'Please enter the Customer Name.');
      return false;
    }
    if (phone.value.trim().isEmpty) {
      AppNotification.error('Required Field Missing', 'Please enter the Phone Number.');
      return false;
    }
    if (address.value.trim().isEmpty) {
      AppNotification.error('Required Field Missing', 'Please enter the Address.');
      return false;
    }
    if (items.isEmpty) {
      AppNotification.error('No Products Added', 'Please add at least one product / service before printing.');
      return false;
    }
    return true;
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    gstInputController.text = '18';
    gstPercentage.value = 18.0;
    itemQuantityController.clear();
    itemPriceController.clear();
    selectedProduct.value = null;
    items.clear();
    currentDate.value = DateTime.now();
    validUptoDate.value = DateTime.now().add(const Duration(days: 30));
    isGstEnabled.value = false;
  }

  // Deduct Stock from backend inventory and Print Black & White A4 PDF
  Future<void> _deductStock() async {
    try {
      final allProducts = await _client.product.getAllProducts();
      for (final item in items) {
        if (item.productId != null) {
          final matchIndex = allProducts.indexWhere((p) => p.id == item.productId);
          if (matchIndex != -1) {
            final existingProduct = allProducts[matchIndex];
            final updatedQty = math.max(0, existingProduct.quantity - item.quantity);

            final updatedProduct = Product(
              id: existingProduct.id,
              name: existingProduct.name,
              categoryId: existingProduct.categoryId,
              category: existingProduct.category,
              brandId: existingProduct.brandId,
              brand: existingProduct.brand,
              quality: existingProduct.quality,
              quantity: updatedQty, // Decremented stock
              buyPrice: existingProduct.buyPrice,
              sellPrice: existingProduct.sellPrice,
              status: existingProduct.status,
            );

            await _client.product.updateExistingProduct(product: updatedProduct);
          }
        }
      }

      // Refresh inventory controller if active so stock table is instantly updated
      if (Get.isRegistered<ProductController>()) {
        Get.find<ProductController>().fetchProducts();
      }
      await refreshProducts();

      AppNotification.success('Stock Reduced', 'Stock quantities have been automatically deducted for printed items.');
    } catch (e) {
      AppNotification.warning('Stock Update Notice', 'Generating bill, but could not update server stock: $e');
    }
  }

  Future<pw.Document?> _generatePdfDoc() async {
    if (!validateBeforePrint()) {
      return null;
    }

    final doc = pw.Document();
    final settings = Get.find<SettingsController>();

    final nameText = nameController.text.trim().isEmpty ? 'Valued Customer' : nameController.text.trim();
    final phoneText = phoneController.text.trim();
    final emailText = emailController.text.trim();
    final addressText = addressController.text.trim();

    final dateStr = _formatDate(currentDate.value);
    final validStr = _formatDate(validUptoDate.value);

    final sub = subTotal;
    final isGst = isGstEnabled.value;
    final gstPct = gstPercentage.value;
    final gstAmt = gstAmount;
    final total = totalAmount;

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.only(left: 32, right: 32, top: 28, bottom: 60),
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
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
                          pw.SizedBox(height: 10),
                          pw.Text('INVOICE / BILL',
                              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Phone: ${settings.storePhone.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                          pw.SizedBox(height: 2),
                          pw.Text('Email: ${settings.storeEmail.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                          if (settings.storeWebsite.value.isNotEmpty) ...[
                            pw.SizedBox(height: 2),
                            pw.Text('Web: ${settings.storeWebsite.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                          ],
                          pw.SizedBox(height: 2),
                          pw.Text('Address: ${settings.storeAddress.value}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
                        ],
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 12),
                  pw.Divider(thickness: 1, color: PdfColors.black),
                  pw.SizedBox(height: 12),

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
                              pw.SizedBox(height: 2),
                              pw.Text('Phone: $phoneText', style: const pw.TextStyle(fontSize: 10.5, color: PdfColors.grey800)),
                            ],
                            if (addressText.isNotEmpty) ...[
                              pw.SizedBox(height: 2),
                              pw.Text('Address: $addressText', style: const pw.TextStyle(fontSize: 10.5, color: PdfColors.grey800)),
                            ],
                            if (emailText.isNotEmpty) ...[
                              pw.SizedBox(height: 2),
                              pw.Text('Email: $emailText', style: const pw.TextStyle(fontSize: 10.5, color: PdfColors.grey800)),
                            ],
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 16),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('Date :   $dateStr',
                              style: pw.TextStyle(fontSize: 10.5, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                          pw.SizedBox(height: 4),
                          pw.Text('Due Date :   $validStr',
                              style: pw.TextStyle(fontSize: 10.5, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                        ],
                      ),
                    ],
                  ),

                  pw.SizedBox(height: 12),

                  // 3. Products / Services Table (Max 13 items)
                  pw.Container(
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(color: PdfColors.black, width: 1.5),
                        top: pw.BorderSide(color: PdfColors.black, width: 1.5),
                      ),
                    ),
                    padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: pw.Row(
                      children: [
                        pw.SizedBox(
                          width: 40,
                          child: pw.Text('NO',
                              style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                        ),
                        pw.Expanded(
                          child: pw.Text('Product / Service Description',
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
                      padding: const pw.EdgeInsets.symmetric(vertical: 18),
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
                        padding: const pw.EdgeInsets.symmetric(vertical: 3.5, horizontal: 4),
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
                                _formatPdfCurrency(items[idx].amount),
                                textAlign: pw.TextAlign.right,
                                style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold, color: PdfColors.black),
                              ),
                            ),
                          ],
                        ),
                      ),

                  pw.SizedBox(height: 8),

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
                            pw.SizedBox(height: 4),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('GST (${gstPct.toStringAsFixed(gstPct == gstPct.toInt() ? 0 : 1)}%)',
                                    style: const pw.TextStyle(fontSize: 11, color: PdfColors.black)),
                                pw.Text(_formatPdfCurrency(gstAmt),
                                    style: const pw.TextStyle(fontSize: 11, color: PdfColors.black)),
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Divider(thickness: 1, color: PdfColors.black),
                            pw.SizedBox(height: 3),
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
                            pw.SizedBox(height: 4),
                            pw.Divider(thickness: 1, color: PdfColors.black),
                            pw.SizedBox(height: 3),
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
                ],
              ),

              // 5. Footer (Terms & Conditions + Authorized Signature)
              pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Divider(thickness: 1, color: PdfColors.grey600),
                  pw.SizedBox(height: 8),
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
                          pw.SizedBox(height: 24),
                          pw.Text('Authorized Signature',
                              style: pw.TextStyle(fontSize: 10.5, fontWeight: pw.FontWeight.bold, color: PdfColors.black)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return doc;
  }

  Future<void> printInvoiceBillPdf() async {
    final doc = await _generatePdfDoc();
    if (doc == null) return;

    await _deductStock();

    final nameText = nameController.text.trim().isEmpty ? 'Valued Customer' : nameController.text.trim();

    if (GetPlatform.isMobile) {
      final bool printed = await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save(),
        name: nameText.isEmpty
            ? 'Invoice_Bill'
            : 'Invoice_Bill_${nameText.replaceAll(' ', '_')}',
      );
      if (printed) clearForm();
      return;
    }

    final bool printed = await SaaSPrintModal.show(
      documentTitle: 'INVOICE / BILL',
      documentNumber: nameText.replaceAll(' ', '_'),
      customerName: nameText.isEmpty ? 'Walk-in Customer' : nameText,
      totalAmountText: _formatPdfCurrency(totalAmount),
      onLayout: (PdfPageFormat format) async => doc.save(),
    );

    if (printed) clearForm();
  }

  Future<void> shareInvoiceBillPdf() async {
    final doc = await _generatePdfDoc();
    if (doc == null) return;

    await _deductStock();

    final bytes = await doc.save();
    final nameText = nameController.text.trim().isEmpty ? 'Valued Customer' : nameController.text.trim();
    final fileName = nameText.isEmpty
        ? 'Invoice_Bill.pdf'
        : 'Invoice_Bill_${nameText.replaceAll(' ', '_')}.pdf';
        
    await Printing.sharePdf(bytes: bytes, filename: fileName);
    clearForm();
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';
  }

  String _formatPdfCurrency(double amount, {bool showSign = false}) {
    final absAmount = amount.abs();
    final parts = absAmount.toStringAsFixed(2).split('.');
    String intPart = parts[0];
    final decPart = parts[1];

    if (intPart.length > 3) {
      final lastThree = intPart.substring(intPart.length - 3);
      final remaining = intPart.substring(0, intPart.length - 3);
      final buffer = StringBuffer();
      for (int i = 0; i < remaining.length; i++) {
        if (i > 0 && (remaining.length - i) % 2 == 0) {
          buffer.write(',');
        }
        buffer.write(remaining[i]);
      }
      intPart = '${buffer.toString()},$lastThree';
    }

    final formatted = 'Rs. $intPart.$decPart';
    if (amount < 0) return '-$formatted';
    if (showSign && amount > 0) return '+ $formatted';
    return formatted;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    gstInputController.dispose();
    itemQuantityController.dispose();
    itemPriceController.dispose();
    super.onClose();
  }
}
