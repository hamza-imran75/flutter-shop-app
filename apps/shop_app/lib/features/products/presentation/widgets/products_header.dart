import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../cart/presentation/widgets/cart_button.dart';

class ProductsHeader extends StatelessWidget {
  const ProductsHeader({
    super.key,
    required this.onTitleLongPress,
    required this.onLogout,
  });

  final VoidCallback onTitleLongPress;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l + 2,
        AppSpacing.m,
        AppSpacing.l,
        AppSpacing.s,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: onTitleLongPress,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText('Discover', style: AppTextStyles.title),
                  const SizedBox(height: 2),
                  AppText('Hand-picked products', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
          const CartButton(),
          AppIconButton(
            icon: LucideIcons.logOut,
            semanticLabel: 'Sign out',
            onPressed: onLogout,
          ),
        ],
      ),
    );
  }
}
