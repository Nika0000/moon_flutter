import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class MoonAlertProperties extends ThemeExtension<MoonAlertProperties> with DiagnosticableTreeMixin {
  /// Border radius for alert.
  final BorderRadiusGeometry borderRadius;

  /// Horizontal space between alert leading, trailing and label.
  final double horizontalGap;

  /// Alert Widget minimum height.
  final double minimumHeight;

  /// Vertical space between alert header and body.
  final double verticalGap;

  /// Alert transition duration (show and hide animation).
  final Duration transitionDuration;

  /// Alert transition curve (show and hide animation).
  final Curve transitionCurve;

  /// Alert padding.
  final EdgeInsetsGeometry padding;

  /// Alert content text style.
  final TextStyle contentTextStyle;

  /// Alert label text style.
  final TextStyle labelTextStyle;

  const MoonAlertProperties({
    required this.borderRadius,
    required this.horizontalGap,
    required this.minimumHeight,
    required this.verticalGap,
    required this.transitionDuration,
    required this.transitionCurve,
    required this.padding,
    required this.contentTextStyle,
    required this.labelTextStyle,
  });

  @override
  MoonAlertProperties copyWith({
    BorderRadiusGeometry? borderRadius,
    double? horizontalGap,
    double? minimumHeight,
    double? verticalGap,
    Duration? transitionDuration,
    Curve? transitionCurve,
    EdgeInsetsGeometry? padding,
    TextStyle? contentTextStyle,
    TextStyle? labelTextStyle,
  }) {
    return MoonAlertProperties(
      borderRadius: borderRadius ?? this.borderRadius,
      horizontalGap: horizontalGap ?? this.horizontalGap,
      minimumHeight: minimumHeight ?? this.minimumHeight,
      verticalGap: verticalGap ?? this.verticalGap,
      transitionDuration: transitionDuration ?? this.transitionDuration,
      transitionCurve: transitionCurve ?? this.transitionCurve,
      padding: padding ?? this.padding,
      contentTextStyle: contentTextStyle ?? this.contentTextStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    );
  }

  @override
  MoonAlertProperties lerp(ThemeExtension<MoonAlertProperties>? other, double t) {
    if (other is! MoonAlertProperties) return this;

    return MoonAlertProperties(
      borderRadius: BorderRadiusGeometry.lerp(borderRadius, other.borderRadius, t)!,
      horizontalGap: lerpDouble(horizontalGap, other.horizontalGap, t)!,
      minimumHeight: lerpDouble(minimumHeight, other.minimumHeight, t)!,
      verticalGap: lerpDouble(verticalGap, other.verticalGap, t)!,
      transitionDuration: lerpDuration(transitionDuration, other.transitionDuration, t),
      transitionCurve: other.transitionCurve,
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t)!,
      contentTextStyle: TextStyle.lerp(contentTextStyle, other.contentTextStyle, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonAlertProperties"))
      ..add(DiagnosticsProperty<BorderRadiusGeometry>("borderRadius", borderRadius))
      ..add(DoubleProperty("horizontalGap", horizontalGap))
      ..add(DoubleProperty("minimumHeight", minimumHeight))
      ..add(DoubleProperty("verticalGap", verticalGap))
      ..add(DiagnosticsProperty<Duration>("transitionDuration", transitionDuration))
      ..add(DiagnosticsProperty<Curve>("transitionCurve", transitionCurve))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry>("padding", padding))
      ..add(DiagnosticsProperty<TextStyle>("contentTextStyle", contentTextStyle))
      ..add(DiagnosticsProperty<TextStyle>("labelTextStyle", labelTextStyle));
  }
}
