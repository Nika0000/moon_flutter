import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/progress_pin/progress_pin_colors.dart';
import 'package:moon_design/src/theme/progress_pin/progress_pin_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonProgressPinTheme extends ThemeExtension<MoonProgressPinTheme> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Progress pin colors.
  final MoonProgressPinColors colors;

  /// Progress pin properties.
  final MoonProgressPinProperties properties;

  MoonProgressPinTheme({
    required this.tokens,
    MoonProgressPinColors? colors,
    MoonProgressPinProperties? properties,
  })  : colors = colors ??
            MoonProgressPinColors(
              pinColor: tokens.colors.popo,
              pinBorderColor: tokens.colors.goten,
              thumbColor: tokens.colors.goten,
              shadowColor: tokens.colors.popo,
              textColor: tokens.colors.goten,
            ),
        properties = properties ??
            MoonProgressPinProperties(
              arrowHeight: 6,
              arrowWidth: tokens.sizes.x4s,
              pinDistance: tokens.sizes.x5s,
              pinWidth: 36,
              pinBorderWidth: tokens.sizes.x6s,
              shadowElevation: 6,
              textStyle: tokens.typography.caption.text10,
            );

  @override
  MoonProgressPinTheme copyWith({
    MoonTokens? tokens,
    MoonProgressPinColors? colors,
    MoonProgressPinProperties? properties,
  }) {
    return MoonProgressPinTheme(
      tokens: tokens ?? this.tokens,
      colors: colors ?? this.colors,
      properties: properties ?? this.properties,
    );
  }

  @override
  MoonProgressPinTheme lerp(ThemeExtension<MoonProgressPinTheme>? other, double t) {
    if (other is! MoonProgressPinTheme) return this;

    return MoonProgressPinTheme(
      tokens: tokens.lerp(other.tokens, t),
      colors: colors.lerp(other.colors, t),
      properties: properties.lerp(other.properties, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder diagnosticProperties) {
    super.debugFillProperties(diagnosticProperties);
    diagnosticProperties
      ..add(DiagnosticsProperty("type", "MoonProgressPinTheme"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonProgressPinColors>("colors", colors))
      ..add(DiagnosticsProperty<MoonProgressPinProperties>("properties", properties));
  }
}
