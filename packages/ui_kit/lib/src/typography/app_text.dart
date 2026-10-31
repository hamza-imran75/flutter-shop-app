import 'package:flutter/widgets.dart';

import 'app_text_styles.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.style,
    this.color,
    this.maxLines,
    this.textAlign,
  });

  final String data;
  final TextStyle? style;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final base = style ?? AppTextStyles.body;
    return Text(
      data,
      style: color == null ? base : base.copyWith(color: color),
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
