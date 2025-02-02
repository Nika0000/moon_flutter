import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/theme/tokens/sizes.dart';
import 'package:moon_design/src/theme/tokens/transitions.dart';
import 'package:moon_design/src/theme/tokens/typography/typography.dart';
import 'package:moon_design/src/utils/extensions.dart';
import 'package:moon_design/src/utils/squircle/squircle_border.dart';
import 'package:moon_design/src/widgets/common/base_control.dart';
import 'package:moon_design/src/widgets/common/border_container.dart';
import 'package:moon_design/src/widgets/common/error_message_widgets.dart';
import 'package:moon_design/src/widgets/text_input/form_text_input.dart';
import 'package:moon_tokens/moon_tokens.dart';

enum MoonTextInputGroupOrientation {
  vertical,
  horizontal,
}

typedef MoonTextInputGroupErrorBuilder = Widget Function(BuildContext context, List<String> errorText);

class MoonTextInputGroup extends StatefulWidget {
  /// If false the widget is "disabled": it ignores taps and has a reduced opacity.
  final bool enabled;

  /// The border radius of the text input group.
  final BorderRadiusGeometry? borderRadius;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// The background color of the text input group.
  final Color? backgroundColor;

  /// The default border color of the text input group.
  final Color? borderColor;

  /// The color of the error state of text input group.
  final Color? errorColor;

  /// The text color of the hint in text input group.
  final Color? hintTextColor;

  /// The border color of the hovered text input group.
  final Color? hoverBorderColor;

  /// The transition duration for disable animation.
  final Duration? transitionDuration;

  /// The transition curve for disable animation.
  final Curve? transitionCurve;

  /// The padding around helper widget or error builder.
  final EdgeInsetsGeometry? helperPadding;

  /// The padding around the text content.
  final EdgeInsetsGeometry? textPadding;

  /// Custom decoration for the text input group.
  final Decoration? decoration;

  /// The semantic label for the text input group widget.
  final String? semanticLabel;

  /// The text style to use for the helper or error state text.
  final TextStyle? helperTextStyle;

  /// The orientation of the text input group.
  final MoonTextInputGroupOrientation orientation;

  /// The children of the text input group.
  final List<MoonFormTextInput> children;

  /// Builder for the error widget.
  final MoonTextInputGroupErrorBuilder? errorBuilder;

  /// The widget in the helper slot of the text input group.
  final Widget? helper;

  /// MDS TextInputGroup widget
  const MoonTextInputGroup({
    super.key,
    this.enabled = true,
    this.borderRadius,
    this.clipBehavior,
    this.backgroundColor,
    this.borderColor,
    this.errorColor,
    this.hintTextColor,
    this.hoverBorderColor,
    this.transitionDuration,
    this.transitionCurve,
    this.helperPadding,
    this.textPadding,
    this.decoration,
    this.semanticLabel,
    this.helperTextStyle,
    this.orientation = MoonTextInputGroupOrientation.vertical,
    required this.children,
    this.errorBuilder,
    this.helper,
  });

  @override
  State<MoonTextInputGroup> createState() => _MoonTextInputGroupState();
}

class _MoonTextInputGroupState extends State<MoonTextInputGroup> {
  late final List<String?> _validatorErrors = List.filled(widget.children.length, null);
  late List<String?> _previousValidatorErrors;

  bool get _groupHasValidationError => _validatorErrors.nonNulls.toList().isNotEmpty;
  bool get _groupHasErrorText =>
      widget.children.any((MoonFormTextInput child) => child.configuration.errorText != null);

  bool get _groupHasError => _groupHasValidationError || _groupHasErrorText;

  bool get _groupHasAllValidationErrors => _validatorErrors.nonNulls.length == widget.children.length;
  bool get _groupHasAllErrorTexts =>
      widget.children.every((MoonFormTextInput child) => child.configuration.errorText != null);

  bool get _groupIsInErrorState => _groupHasAllValidationErrors || _groupHasAllErrorTexts;
  bool get _shouldShowError => _groupHasError || _groupIsInErrorState;

  void _handleValidationError(int index, String? errorText) {
    _previousValidatorErrors = _validatorErrors;

    if (_previousValidatorErrors[index] == errorText) return;

    if (errorText != null) {
      _validatorErrors[index] = errorText;
    } else {
      _validatorErrors[index] = null;
    }

    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      if (!mounted) return;
      // Rebuild the widget to show the error
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry effectiveBorderRadius = widget.borderRadius ??
        context.moonTheme?.textInputGroupTheme.properties.borderRadius ??
        BorderRadius.circular(8);

    final Color effectiveBackgroundColor = widget.backgroundColor ??
        context.moonTheme?.textInputGroupTheme.colors.backgroundColor ??
        MoonColors.light.goku;

    final Color effectiveBorderColor =
        widget.borderColor ?? context.moonTheme?.textInputGroupTheme.colors.borderColor ?? MoonColors.light.beerus;

    final Color effectiveErrorColor =
        widget.errorColor ?? context.moonTheme?.textInputGroupTheme.colors.errorColor ?? MoonColors.light.chichi;

    final Color effectiveHelperTextColor = widget.hintTextColor ??
        context.moonTheme?.textInputGroupTheme.colors.helperTextColor ??
        MoonColors.light.trunks;

    final EdgeInsetsGeometry effectiveHelperPadding = widget.helperPadding ??
        context.moonTheme?.textInputGroupTheme.properties.helperPadding ??
        EdgeInsets.only(
          left: MoonSizes.sizes.x3s,
          top: MoonSizes.sizes.x4s,
          right: MoonSizes.sizes.x3s,
        );

    final TextStyle effectiveHelperTextStyle = widget.helperTextStyle ??
        context.moonTheme?.textInputGroupTheme.properties.helperTextStyle ??
        MoonTypography.typography.body.text12;

    final Duration effectiveTransitionDuration = widget.transitionDuration ??
        context.moonTheme?.textInputGroupTheme.properties.transitionDuration ??
        MoonTransitions.transitions.defaultTransitionDuration;

    final Curve effectiveTransitionCurve = widget.transitionCurve ??
        context.moonTheme?.textInputGroupTheme.properties.transitionCurve ??
        MoonTransitions.transitions.defaultTransitionCurve;

    final List<String> effectiveErrorMessages = _validatorErrors.nonNulls.toList().isNotEmpty
        ? _validatorErrors.nonNulls.toList()
        : widget.children.map((MoonFormTextInput child) => child.configuration.errorText).nonNulls.toList();

    List<Widget> childrenWithDivider({required bool shouldHideDivider}) => List.generate(
          widget.children.length * 2 - 1,
          (int index) {
            final int derivedIndex = index ~/ 2;

            final bool selfShowError = ((widget.children[derivedIndex].configuration.errorText != null &&
                        _validatorErrors[derivedIndex] == null) &&
                    !_groupHasValidationError &&
                    !_groupHasAllErrorTexts) ||
                (_validatorErrors[derivedIndex] != null && !_groupHasAllValidationErrors);

            Widget child = MoonFormTextInput(
              activeBorderColor: widget.children[derivedIndex].configuration.activeBorderColor,
              autocorrect: widget.children[derivedIndex].configuration.autocorrect,
              autofillHints: widget.children[derivedIndex].configuration.autofillHints,
              autofocus: widget.children[derivedIndex].configuration.autofocus,
              autovalidateMode: widget.children[derivedIndex].configuration.autovalidateMode,
              backgroundColor: Colors.transparent,
              borderRadius: widget.children[derivedIndex].configuration.borderRadius,
              canRequestFocus: widget.children[derivedIndex].configuration.canRequestFocus,
              clipBehavior: widget.children[derivedIndex].configuration.clipBehavior,
              contentInsertionConfiguration: widget.children[derivedIndex].configuration.contentInsertionConfiguration,
              contextMenuBuilder: widget.children[derivedIndex].configuration.contextMenuBuilder,
              controller: widget.children[derivedIndex].configuration.controller,
              cursorColor: widget.children[derivedIndex].configuration.cursorColor,
              cursorHeight: widget.children[derivedIndex].configuration.cursorHeight,
              cursorOpacityAnimates: widget.children[derivedIndex].configuration.cursorOpacityAnimates,
              cursorRadius: widget.children[derivedIndex].configuration.cursorRadius,
              cursorWidth: widget.children[derivedIndex].configuration.cursorWidth,
              decoration: widget.children[derivedIndex].configuration.decoration,
              dragStartBehavior: widget.children[derivedIndex].configuration.dragStartBehavior,
              enabled: widget.children[derivedIndex].configuration.enabled,
              enableIMEPersonalizedLearning: widget.children[derivedIndex].configuration.enableIMEPersonalizedLearning,
              enableInteractiveSelection: widget.children[derivedIndex].configuration.enableInteractiveSelection,
              enableSuggestions: widget.children[derivedIndex].configuration.enableSuggestions,
              errorBorderColor:
                  selfShowError ? widget.children[derivedIndex].configuration.errorColor : Colors.transparent,
              errorBuilder: (BuildContext context, String? errorText) => const SizedBox.shrink(),
              errorColor: widget.children[derivedIndex].configuration.errorColor,
              errorText: widget.children[derivedIndex].configuration.errorText,
              expands: widget.children[derivedIndex].configuration.expands,
              focusNode: widget.children[derivedIndex].configuration.focusNode,
              gap: widget.children[derivedIndex].configuration.gap,
              hasFloatingLabel: widget.children[derivedIndex].configuration.hasFloatingLabel,
              height: widget.children[derivedIndex].configuration.height,
              helper: widget.children[derivedIndex].configuration.helper,
              helperPadding: widget.children[derivedIndex].configuration.helperPadding,
              helperTextStyle: widget.children[derivedIndex].configuration.helperTextStyle,
              hintText: widget.children[derivedIndex].configuration.hintText,
              hintTextColor: widget.children[derivedIndex].configuration.hintTextColor,
              hoverBorderColor: widget.children[derivedIndex].configuration.hoverBorderColor,
              inactiveBorderColor: Colors.transparent,
              initialValue: widget.children[derivedIndex].configuration.initialValue,
              inputFormatters: widget.children[derivedIndex].configuration.inputFormatters,
              keyboardAppearance: widget.children[derivedIndex].configuration.keyboardAppearance,
              keyboardType: widget.children[derivedIndex].configuration.keyboardType,
              leading: widget.children[derivedIndex].configuration.leading,
              magnifierConfiguration: widget.children[derivedIndex].configuration.magnifierConfiguration,
              maxLength: widget.children[derivedIndex].configuration.maxLength,
              maxLengthEnforcement: widget.children[derivedIndex].configuration.maxLengthEnforcement,
              maxLines: widget.children[derivedIndex].configuration.maxLines,
              minLines: widget.children[derivedIndex].configuration.minLines,
              mouseCursor: widget.children[derivedIndex].configuration.mouseCursor,
              obscureText: widget.children[derivedIndex].configuration.obscureText,
              obscuringCharacter: widget.children[derivedIndex].configuration.obscuringCharacter,
              onAppPrivateCommand: widget.children[derivedIndex].configuration.onAppPrivateCommand,
              onChanged: widget.children[derivedIndex].configuration.onChanged,
              onEditingComplete: widget.children[derivedIndex].configuration.onEditingComplete,
              onSubmitted: widget.children[derivedIndex].configuration.onSubmitted,
              onSaved: widget.children[derivedIndex].configuration.onSaved,
              onTap: widget.children[derivedIndex].configuration.onTap,
              onTapOutside: widget.children[derivedIndex].configuration.onTapOutside,
              padding: widget.children[derivedIndex].configuration.padding,
              readOnly: widget.children[derivedIndex].configuration.readOnly,
              restorationId: widget.children[derivedIndex].configuration.restorationId,
              scribbleEnabled: widget.children[derivedIndex].configuration.scribbleEnabled,
              scrollController: widget.children[derivedIndex].configuration.scrollController,
              scrollPadding: widget.children[derivedIndex].configuration.scrollPadding,
              scrollPhysics: widget.children[derivedIndex].configuration.scrollPhysics,
              selectionControls: widget.children[derivedIndex].configuration.selectionControls,
              selectionHeightStyle: widget.children[derivedIndex].configuration.selectionHeightStyle,
              selectionWidthStyle: widget.children[derivedIndex].configuration.selectionWidthStyle,
              showCursor: widget.children[derivedIndex].configuration.showCursor,
              smartDashesType: widget.children[derivedIndex].configuration.smartDashesType,
              smartQuotesType: widget.children[derivedIndex].configuration.smartQuotesType,
              spellCheckConfiguration: widget.children[derivedIndex].configuration.spellCheckConfiguration,
              strutStyle: widget.children[derivedIndex].configuration.strutStyle,
              style: widget.children[derivedIndex].configuration.style,
              textAlign: widget.children[derivedIndex].configuration.textAlign,
              textAlignVertical: widget.children[derivedIndex].configuration.textAlignVertical,
              textCapitalization: widget.children[derivedIndex].configuration.textCapitalization,
              textColor: widget.children[derivedIndex].configuration.textColor,
              textDirection: widget.children[derivedIndex].configuration.textDirection,
              textInputAction: widget.children[derivedIndex].configuration.textInputAction,
              textInputSize: widget.children[derivedIndex].configuration.textInputSize,
              trailing: widget.children[derivedIndex].configuration.trailing,
              transitionCurve: widget.children[derivedIndex].configuration.transitionCurve,
              transitionDuration: widget.children[derivedIndex].configuration.transitionDuration,
              undoController: widget.children[derivedIndex].configuration.undoController,
              validationStatusCallback: (errorText) => _handleValidationError(derivedIndex, errorText),
              validator: widget.children[derivedIndex].configuration.validator,
              width: widget.children[derivedIndex].configuration.width,
            );

            child = widget.children[derivedIndex].configuration.width != null
                ? SizedBox(
                    width: widget.children[derivedIndex].configuration.width,
                    child: child,
                  )
                : Flexible(child: child);

            return index.isEven
                ? child
                // Animated divider
                : BorderContainer(
                    height: widget.orientation == MoonTextInputGroupOrientation.horizontal ? double.infinity : 1,
                    width: widget.orientation == MoonTextInputGroupOrientation.vertical ? double.infinity : 1,
                    duration: effectiveTransitionDuration,
                    curve: effectiveTransitionCurve,
                    border: MoonSquircleBorder(
                      borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                      side: BorderSide(
                        color: (!_groupHasValidationError && _groupHasAllErrorTexts) || _groupHasAllValidationErrors
                            ? effectiveErrorColor
                            : shouldHideDivider || (_groupHasError || _groupHasValidationError)
                                ? Colors.transparent
                                : effectiveBorderColor,
                      ),
                    ),
                    child: const SizedBox.shrink(),
                  );
          },
          growable: false,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MoonBaseControl(
          semanticLabel: widget.semanticLabel,
          isFocusable: false,
          showFocusEffect: false,
          onTap: widget.enabled ? () {} : null,
          builder: (BuildContext context, bool isEnabled, bool isHovered, bool isFocused, bool isPressed) {
            return BorderContainer(
              clipBehavior: widget.clipBehavior ?? Clip.none,
              backgroundColor: effectiveBackgroundColor,
              decoration: widget.decoration,
              duration: effectiveTransitionDuration,
              curve: effectiveTransitionCurve,
              border: MoonSquircleBorder(
                borderRadius: effectiveBorderRadius.squircleBorderRadius(context),
                side: BorderSide(
                  color: (!_groupHasValidationError && _groupHasAllErrorTexts) || _groupHasAllValidationErrors
                      ? effectiveErrorColor
                      : effectiveBorderColor,
                ),
              ),
              child: _InputGroupOrientation(
                orientation: widget.orientation,
                children: childrenWithDivider(shouldHideDivider: isHovered || isFocused),
              ),
            );
          },
        ),
        if (widget.helper != null || _shouldShowError)
          IconTheme(
            data: IconThemeData(
              color: _shouldShowError ? effectiveErrorColor : effectiveHelperTextColor,
            ),
            child: DefaultTextStyle(
              style: effectiveHelperTextStyle.copyWith(
                color: _shouldShowError ? effectiveErrorColor : effectiveHelperTextColor,
              ),
              child: Padding(
                padding: effectiveHelperPadding,
                child: _shouldShowError
                    ? (widget.errorBuilder?.call(context, effectiveErrorMessages) ??
                        MoonErrorMessages(errors: effectiveErrorMessages))
                    : widget.helper,
              ),
            ),
          ),
      ],
    );
  }
}

class _InputGroupOrientation extends StatelessWidget {
  final MoonTextInputGroupOrientation orientation;
  final List<Widget> children;

  const _InputGroupOrientation({
    required this.orientation,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return switch (orientation) {
      MoonTextInputGroupOrientation.vertical => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      MoonTextInputGroupOrientation.horizontal => SizedBox(
          height: 56,
          width: 300,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
    };
  }
}
