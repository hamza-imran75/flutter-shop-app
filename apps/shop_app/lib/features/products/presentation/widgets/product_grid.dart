import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

const productGridPadding = EdgeInsets.fromLTRB(
  AppSpacing.l,
  AppSpacing.s,
  AppSpacing.l,
  AppSpacing.l,
);

/// Two columns whose row height follows the text scale, so large text grows
/// the card instead of overflowing it.
SliverGridDelegate productGridDelegate(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  final cardWidth = (width - productGridPadding.horizontal - AppSpacing.m) / 2;
  final scale = MediaQuery.textScalerOf(context).scale(1);
  const textBlock = 112.0;
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: AppSpacing.m,
    crossAxisSpacing: AppSpacing.m,
    mainAxisExtent: cardWidth * 0.95 + textBlock * scale,
  );
}
