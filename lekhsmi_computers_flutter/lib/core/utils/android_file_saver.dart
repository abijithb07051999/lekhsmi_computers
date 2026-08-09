import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:printing/printing.dart';
import 'package:lekhsmi_computers_flutter/core/widgets/app_notification.dart';
import 'package:file_selector/file_selector.dart';

class AndroidFileSaver {
  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  static String _getMonthFullName(int month) {
    if (month >= 1 && month <= 12) {
      return _months[month - 1];
    }
    return 'January';
  }

  /// Generates the timestamped filename:
  /// Quotation -> FullYear_Quotation_Day_MonthFullName_HHSS.pdf
  /// Invoice   -> FullYear_Invoice_Day_MonthFullName_HHSS.pdf
  static String generateFileName({required bool isQuotation}) {
    final now = DateTime.now();
    final year = now.year.toString();
    final monthFullName = _getMonthFullName(now.month);
    final day = now.day.toString().padLeft(2, '0');
    final hh = now.hour.toString().padLeft(2, '0');
    final ss = now.second.toString().padLeft(2, '0');
    final timeStr = '$hh$ss';

    final typeStr = isQuotation ? 'Quotation' : 'Invoice';
    return '${year}_${typeStr}_${day}_${monthFullName}_$timeStr.pdf';
  }

  /// Resolves the Lekhsmi_computers_QU_IN directory path across Android (mobile/tablet) and desktop.
  static Future<Directory> getStorageDirectory() async {
    if (!kIsWeb && Platform.isAndroid) {
      // Primary: /storage/emulated/0/Lekhsmi_computers_QU_IN
      final List<String> candidates = [
        '/storage/emulated/0/Lekhsmi_computers_QU_IN',
        '/storage/emulated/0/Download/Lekhsmi_computers_QU_IN',
        '/storage/emulated/0/Documents/Lekhsmi_computers_QU_IN',
      ];

      for (final path in candidates) {
        try {
          final dir = Directory(path);
          if (!await dir.exists()) {
            await dir.create(recursive: true);
          }
          return dir;
        } catch (_) {
          continue;
        }
      }
    }

    // Fallback for Desktop/iOS/other environments: user's Documents or Current Directory
    try {
      final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '.';
      final dir = Directory('$home/Documents/Lekhsmi_computers_QU_IN');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return dir;
    } catch (_) {
      final dir = Directory('Lekhsmi_computers_QU_IN');
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      return dir;
    }
  }

  /// Automatically saves the PDF to Lekhsmi_computers_QU_IN directory with timestamped filename.
  static Future<String> savePdf({
    required bool isQuotation,
    required Uint8List bytes,
  }) async {
    final fileName = generateFileName(isQuotation: isQuotation);
    try {
      final dir = await getStorageDirectory();
      final filePath = '${dir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);
      AppNotification.success(
        'PDF Saved Successfully',
        'File stored in Lekhsmi_computers_QU_IN:\n$fileName',
      );
      return filePath;
    } catch (e) {
      // Fallback share if direct filesystem access fails
      await Printing.sharePdf(bytes: bytes, filename: fileName);
      return fileName;
    }
  }

  /// Opens a native file save dialog for Desktop and writes the PDF bytes to the chosen location.
  static Future<void> savePdfWithDialog({
    required bool isQuotation,
    required Uint8List bytes,
  }) async {
    final fileName = generateFileName(isQuotation: isQuotation);
    try {
      final FileSaveLocation? result = await getSaveLocation(
        suggestedName: fileName,
      );
      
      if (result == null) {
        // User canceled the dialog
        return;
      }
      
      final XFile file = XFile.fromData(bytes, name: fileName, mimeType: 'application/pdf');
      await file.saveTo(result.path);
      
      AppNotification.success(
        'PDF Saved Successfully',
        'Saved as:\n${result.path.split(Platform.pathSeparator).last}',
      );
    } catch (e) {
      AppNotification.error('Save Failed', 'Could not save the PDF: $e');
    }
  }

  /// Saves the PDF to Lekhsmi_computers_QU_IN and launches the native Share sheet.
  static Future<void> sharePdf({
    required bool isQuotation,
    required Uint8List bytes,
  }) async {
    final fileName = generateFileName(isQuotation: isQuotation);
    try {
      // Save automatically first so a copy is always in Lekhsmi_computers_QU_IN
      final dir = await getStorageDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
    } catch (_) {
      // Ignore save error during share fallback
    }
    await Printing.sharePdf(bytes: bytes, filename: fileName);
  }
}
