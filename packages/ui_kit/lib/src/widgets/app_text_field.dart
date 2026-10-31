import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../tokens/app_colors.dart';
import '../tokens/app_spacing.dart';
import '../typography/app_text_styles.dart';
import 'app_icon.dart';

/// Single-line input built on [EditableText]. Tapping anywhere on the field
/// focuses it, which [EditableText] does not do on its own.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.hasError = false,
    this.enabled = true,
    this.autofillHints,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool hasError;
  final bool enabled;
  final Iterable<String>? autofillHints;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode? _ownedFocus;
  FocusNode get _focus => widget.focusNode ?? (_ownedFocus ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onChange);
    widget.controller.addListener(_onChange);
  }

  @override
  void dispose() {
    _focus.removeListener(_onChange);
    widget.controller.removeListener(_onChange);
    _ownedFocus?.dispose();
    super.dispose();
  }

  void _onChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final focused = _focus.hasFocus;
    final borderColor = widget.hasError
        ? AppColors.danger
        : focused
            ? AppColors.primaryTop
            : AppColors.border;
    final empty = widget.controller.text.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.s - 2),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.enabled ? _focus.requestFocus : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m + 2),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadii.m),
              border: Border.all(color: borderColor),
              boxShadow: [
                if (focused && !widget.hasError)
                  BoxShadow(
                    color: AppColors.primaryTop.withValues(alpha: 0.18),
                    blurRadius: 0,
                    spreadRadius: 3,
                  ),
              ],
            ),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  AppIcon(
                    widget.icon!,
                    size: 18,
                    color: focused
                        ? AppColors.textPrimary
                        : AppColors.textTertiary,
                  ),
                  const SizedBox(width: AppSpacing.m),
                ],
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      if (empty && widget.hint != null)
                        IgnorePointer(
                          child: Text(
                            widget.hint!,
                            style: AppTextStyles.body
                                .copyWith(color: AppColors.textTertiary),
                          ),
                        ),
                      EditableText(
                        controller: widget.controller,
                        focusNode: _focus,
                        style: AppTextStyles.body,
                        cursorColor: AppColors.primaryTop,
                        backgroundCursorColor: AppColors.surfaceRaised,
                        selectionColor:
                            AppColors.primaryTop.withValues(alpha: 0.35),
                        obscureText: widget.obscureText,
                        autocorrect: false,
                        enableSuggestions: false,
                        readOnly: !widget.enabled,
                        keyboardType: widget.keyboardType,
                        textInputAction: widget.textInputAction,
                        onSubmitted: widget.onSubmitted,
                        autofillHints: widget.autofillHints,
                        keyboardAppearance: Brightness.dark,
                        scrollPadding: const EdgeInsets.only(bottom: 120),
                      ),
                    ],
                  ),
                ),
                if (widget.suffix != null) widget.suffix!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
