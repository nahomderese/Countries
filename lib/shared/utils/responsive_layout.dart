import 'package:flutter/material.dart';

/// ResponsiveLayout widget that renders different layouts based on screen size
///
/// Usage:
/// ```dart
/// ResponsiveLayout(
///   mobile: MobileLayout(),
///   tablet: TabletLayout(),
///   desktop: DesktopLayout(),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.mobile,
    required this.tablet,
    required this.desktop,
    this.tabletBreakpoint = 768,
    this.desktopBreakpoint = 1200,
    super.key,
  });

  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final double tabletBreakpoint;
  final double desktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= desktopBreakpoint) {
      return desktop;
    } else if (width >= tabletBreakpoint) {
      return tablet;
    } else {
      return mobile;
    }
  }
}

/// Extension on BuildContext to easily check device screen type
extension ResponsiveExtension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 768;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 768 &&
      MediaQuery.of(this).size.width < 1200;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1200;

  /// Returns the appropriate horizontal padding based on screen size
  EdgeInsets get responsivePadding {
    if (isDesktop) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    } else if (isTablet) {
      return const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
    } else {
      return const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    }
  }
}
