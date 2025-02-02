import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonAccordionSizeProperties extends ThemeExtension<MoonAccordionSizeProperties> with DiagnosticableTreeMixin {
  /// Accordion border radius.
  final BorderRadiusGeometry borderRadius;

  /// Accordion header height.
  final double headerHeight;

  /// Accordion icon size value.
  final double iconSizeValue;

  /// Padding around accordion label and icon.
  final EdgeInsetsGeometry headerPadding;

  /// Accordion header text style.
  final TextStyle headerTextStyle;

  /// Accordion content text style.
  final TextStyle contentTextStyle;

  const MoonAccordionSizeProperties({
    required this.borderRadius,
    required this.headerHeight,
    required this.iconSizeValue,
    required this.headerPadding,
    required this.headerTextStyle,
    required this.contentTextStyle,
  });

  @override
  MoonAccordionSizeProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? headerHeight,
    double? iconSizeValue,
    EdgeInsetsGeometry? headerPadding,
    TextStyle? headerTextStyle,
    TextStyle? contentTextStyle,
  }) {
    return MoonAccordionSizeProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      headerHeight: headerHeight ?? this.headerHeight,
      iconSizeValue: iconSizeValue ?? this.iconSizeValue,
      headerPadding: headerPadding ?? this.headerPadding,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
    );
  }

  @override
  MoonAccordionSizeProperties lerp(ThemeExtension<MoonAccordionSizeProperties>? other, double t) {
    if (other is! MoonAccordionSizeProperties) return this;

    return MoonAccordionSizeProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      headerHeight: lerpDouble(headerHeight, other.headerHeight, t)!,
      iconSizeValue: lerpDouble(iconSizeValue, other.iconSizeValue, t)!,
      headerPadding: EdgeInsetsGeometry.lerp(headerPadding, other.headerPadding, t)!,
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t)!,
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAccordionSizeProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("headerHeight", headerHeight))
      ..add(DoubleProperty("iconSizeValue", iconSizeValue))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("headerPadding", headerPadding))
      ..add(DiagnosticsProperty<TextStyle>("headerTextStyle", headerTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("contentTextStyle", contentTextStyle));
  }
}
