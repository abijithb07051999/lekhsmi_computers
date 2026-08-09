import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveUtils {
  /// Returns true if the device is considered a Mobile Phone (small to large screen phone, non-tablet).
  static bool isPhone(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      // Material Design phone threshold: shortest side < 600
      final view = View.of(context);
      final physicalSize = view.physicalSize / view.devicePixelRatio;
      final shortestSide = physicalSize.shortestSide;
      return shortestSide < 600 || size.width < 600;
    }
    return size.width < 650;
  }

  /// Returns true if the device is a Tablet or Desktop (width >= 600).
  static bool isTabletOrDesktop(BuildContext context) {
    return !isPhone(context);
  }

  /// Returns true if the available screen width is under 900px.
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 900;
  }
}
