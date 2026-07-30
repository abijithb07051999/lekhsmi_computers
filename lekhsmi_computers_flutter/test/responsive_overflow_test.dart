import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:lekhsmi_computers_flutter/app/features/dashboard/view/dashboard_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/quotation/view/quotation_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/invoice_bill/view/invoice_bill_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/settings/view/settings_view.dart';
import 'package:lekhsmi_computers_flutter/app/features/inventory/purchase/view/purchase_view.dart';
import 'package:lekhsmi_computers_flutter/binding/bindings.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
    LekhsmiBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  group('Responsive Overflow & Pixel Issues Test (15 inch laptop & tablet sizes)', () {
    testWidgets('DashboardView renders without overflow on small screens (1366x768 & 1024x768)',
        (WidgetTester tester) async {
      final List<FlutterErrorDetails> overflowErrors = [];
      final void Function(FlutterErrorDetails)? originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('overflowed')) {
          overflowErrors.add(details);
        }
        originalOnError?.call(details);
      };

      try {
        // Test 1: Standard 15 inch Laptop Resolution (1366x768)
        tester.view.physicalSize = const Size(1366, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: DashboardView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'DashboardView overflowed at 1366x768');

        // Test 2: Compact Tablet Resolution (1024x768)
        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: DashboardView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'DashboardView overflowed at 1024x768');
      } finally {
        FlutterError.onError = originalOnError;
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      }
    });

    testWidgets('QuotationView renders without overflow on small screens (1366x768 & 1024x768)',
        (WidgetTester tester) async {
      final List<FlutterErrorDetails> overflowErrors = [];
      final void Function(FlutterErrorDetails)? originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('overflowed')) {
          overflowErrors.add(details);
        }
        originalOnError?.call(details);
      };

      try {
        // Test 1: 1366x768
        tester.view.physicalSize = const Size(1366, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: QuotationView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'QuotationView overflowed at 1366x768');

        // Test 2: 1024x768 (Tablet size)
        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: QuotationView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'QuotationView overflowed at 1024x768');
      } finally {
        FlutterError.onError = originalOnError;
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      }
    });

    testWidgets('InvoiceBillView renders without overflow on small screens (1366x768 & 1024x768)',
        (WidgetTester tester) async {
      final List<FlutterErrorDetails> overflowErrors = [];
      final void Function(FlutterErrorDetails)? originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('overflowed')) {
          overflowErrors.add(details);
        }
        originalOnError?.call(details);
      };

      try {
        // Test 1: 1366x768
        tester.view.physicalSize = const Size(1366, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: InvoiceBillView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'InvoiceBillView overflowed at 1366x768');

        // Test 2: 1024x768 (Tablet size)
        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: InvoiceBillView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'InvoiceBillView overflowed at 1024x768');
      } finally {
        FlutterError.onError = originalOnError;
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      }
    });

    testWidgets('SettingsView renders without overflow on small screens (1366x768 & 1024x768)',
        (WidgetTester tester) async {
      final List<FlutterErrorDetails> overflowErrors = [];
      final void Function(FlutterErrorDetails)? originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('overflowed')) {
          overflowErrors.add(details);
        }
        originalOnError?.call(details);
      };

      try {
        // Test 1: 1366x768
        tester.view.physicalSize = const Size(1366, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: SettingsView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'SettingsView overflowed at 1366x768');

        // Test 2: 1024x768 (Tablet size)
        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: SettingsView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'SettingsView overflowed at 1024x768');
      } finally {
        FlutterError.onError = originalOnError;
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      }
    });

    testWidgets('PurchaseView renders without overflow on small screens (1366x768 & 1024x768)',
        (WidgetTester tester) async {
      final List<FlutterErrorDetails> overflowErrors = [];
      final void Function(FlutterErrorDetails)? originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails details) {
        if (details.exceptionAsString().contains('overflowed')) {
          overflowErrors.add(details);
        }
        originalOnError?.call(details);
      };

      try {
        tester.view.physicalSize = const Size(1366, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: PurchaseView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'PurchaseView overflowed at 1366x768');

        tester.view.physicalSize = const Size(1024, 768);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const GetMaterialApp(
            home: Scaffold(
              body: PurchaseView(),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(overflowErrors, isEmpty,
            reason: 'PurchaseView overflowed at 1024x768');
      } finally {
        FlutterError.onError = originalOnError;
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      }
    });
  });
}
