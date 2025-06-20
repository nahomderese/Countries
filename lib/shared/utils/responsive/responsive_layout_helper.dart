import 'package:countries_app/shared/globals.dart';
import 'package:flutter/material.dart';

/// A utility class to help with responsive design decisions
class ResponsiveLayoutHelper {
  /// Returns true if the current screen size is desktop-sized
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == ScreenType.Desktop;
  }

  /// Returns true if the current screen size is tablet-sized
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == ScreenType.Tablet;
  }

  /// Returns true if the current screen size is mobile-sized
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == ScreenType.Mobile;
  }

  /// Gets the device type based on current screen width
  static ScreenType getDeviceType(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    if (deviceWidth >= ScreenBreakpoints.desktopBreakpoint) {
      return ScreenType.Desktop;
    }

    if (deviceWidth >= ScreenBreakpoints.tabletBreakpoint) {
      return ScreenType.Tablet;
    }

    return ScreenType.Mobile;
  }
}

/// Screen breakpoints for responsive layouts
class ScreenBreakpoints {
  static const double mobileBreakpoint = 0;
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1200;
}
