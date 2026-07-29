import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lekhsmi_computers_flutter/core/constants/app_colors.dart';

class SaaSDropdown {
  static Widget build<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    bool isExpanded = true,
    Color? backgroundColor,
    Border? border,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    Widget? icon,
    TextStyle? style,
    Widget? hint,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        border: border ?? Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: hint,
          items: items,
          onChanged: onChanged,
          isExpanded: isExpanded,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(14),
          elevation: 12,
          icon: icon ?? const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(AppColors.TEXTSECONDARY)),
          style: style ?? GoogleFonts.inter(
            color: const Color(AppColors.TEXTPRIMARY),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static DropdownMenuItem<T> item<T>({
    required T value,
    required String label,
    Widget? leading,
    TextStyle? style,
  }) {
    return DropdownMenuItem<T>(
      value: value,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              label,
              style: style ?? GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(AppColors.TEXTPRIMARY),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class SaaSDropdownFormField {
  static Widget build<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    bool isExpanded = true,
    String? hintText,
    String? labelText,
    FormFieldValidator<T>? validator,
    InputDecoration? decoration,
  }) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      isExpanded: isExpanded,
      validator: validator,
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(14),
      elevation: 12,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(AppColors.TEXTSECONDARY)),
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: const Color(AppColors.TEXTPRIMARY),
      ),
      decoration: decoration ?? InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(AppColors.HINTTEXT)),
        labelText: labelText,
        labelStyle: GoogleFonts.inter(fontSize: 14, color: const Color(AppColors.TEXTSECONDARY)),
        filled: true,
        fillColor: Colors.white,
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
      ),
    );
  }
}
