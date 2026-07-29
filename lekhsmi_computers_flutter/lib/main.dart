import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/app/routes/app_pages.dart';
import 'package:lekhsmi_computers_flutter/app/routes/app_routes.dart';
import 'package:lekhsmi_computers_flutter/binding/bindings.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: LekhsmiBindings(),
      title: "Lekhsmi Computers",
      initialRoute: AppPages.DASHBOARD,
      getPages: AppRoutes.routes,
      theme: _buildSaaSTheme(),
    );
  }

  ThemeData _buildSaaSTheme() {
    final baseTheme = ThemeData.light(useMaterial3: true);
    return baseTheme.copyWith(
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      canvasColor: Colors.white,
      cardColor: Colors.white,
      primaryColor: const Color(0xFF2563EB),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2563EB),
        primary: const Color(0xFF2563EB),
        surface: Colors.white,
        onSurface: const Color(0xFF0F172A),
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        headerBackgroundColor: const Color(0xFF0F172A),
        headerForegroundColor: Colors.white,
        headerHeadlineStyle: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
        headerHelpStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF94A3B8)),
        weekdayStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF64748B)),
        dayStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: const Color(0xFF0F172A)),
        todayBorder: const BorderSide(color: Color(0xFF2563EB), width: 1.5),
        todayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return const Color(0xFF2563EB);
        }),
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return const Color(0xFF0F172A);
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return const Color(0xFF2563EB);
          return Colors.transparent;
        }),
        yearStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        cancelButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
          foregroundColor: WidgetStateProperty.all(const Color(0xFF64748B)),
        ),
        confirmButtonStyle: ButtonStyle(
          textStyle: WidgetStateProperty.all(GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13)),
          foregroundColor: WidgetStateProperty.all(const Color(0xFF2563EB)),
        ),
      ),
    );
  }
}


