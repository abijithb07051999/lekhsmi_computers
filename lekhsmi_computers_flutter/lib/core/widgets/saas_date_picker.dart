import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';

class SaaSDatePicker {
  static Future<DateTime?> show(
    BuildContext context, {
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(AppColors.PRIMARY),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(AppColors.TEXTPRIMARY),
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 24,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 24,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
              ),
              headerBackgroundColor: Colors.white,
              headerForegroundColor: const Color(0xFF0F172A),
              headerHeadlineStyle: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
              headerHelpStyle: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
              weekdayStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
              dayStyle: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
              yearStyle: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
              todayBorder: const BorderSide(
                color: Color(AppColors.PRIMARY),
                width: 1.5,
              ),
              todayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return const Color(AppColors.PRIMARY);
              }),
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return const Color(AppColors.TEXTPRIMARY);
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(AppColors.PRIMARY);
                }
                return Colors.transparent;
              }),
              cancelButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                foregroundColor: WidgetStateProperty.all(
                  const Color(AppColors.TEXTSECONDARY),
                ),
              ),
              confirmButtonStyle: ButtonStyle(
                textStyle: WidgetStateProperty.all(
                  GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                foregroundColor: WidgetStateProperty.all(
                  const Color(AppColors.PRIMARY),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
