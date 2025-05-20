import 'dart:io';

import 'package:flutter/foundation.dart';

enum LayoutBreakpoint {
  small(name: 'small', start: 375, end: 959),
  medium(name: 'medium', start: 960, end: 1279),
  large(name: 'large', start: 1280, end: 1365),
  xLarge(name: 'xLarge', start: 1366, end: 1919),
  xxLarge(name: 'xxLarge', start: 1920, end: double.infinity);

  const LayoutBreakpoint({
    required this.start,
    required this.end,
    required this.name,
  });

  final double start;
  final double end;
  final String name;
}

extension LayoutBreakpointExtension on LayoutBreakpoint {
  // Mobile
  bool get isSmall => this == LayoutBreakpoint.small;

  // Tablet
  bool get isMedium => this == LayoutBreakpoint.medium;

  bool get isLarge => this == LayoutBreakpoint.large;

  bool get isXLarge => this == LayoutBreakpoint.xLarge;

  bool get isXXLarge => this == LayoutBreakpoint.xxLarge;

  bool get isMobileView {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      return true;
    }
    return isSmall;
  }
}
