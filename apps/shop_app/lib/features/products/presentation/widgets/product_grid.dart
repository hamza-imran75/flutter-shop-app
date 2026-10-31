import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

const productGridPadding = EdgeInsets.fromLTRB(
  AppSpacing.l,
  AppSpacing.s,
  AppSpacing.l,
  AppSpacing.l,
);

const productGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  mainAxisSpacing: AppSpacing.m,
  crossAxisSpacing: AppSpacing.m,
  childAspectRatio: 0.6,
);
