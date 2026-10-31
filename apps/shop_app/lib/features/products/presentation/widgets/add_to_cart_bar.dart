import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

enum _CartStatus { idle, adding, added }

/// Sticky call to action. The cart itself is out of scope, so this only plays
/// the idle, adding and added states.
class AddToCartBar extends StatefulWidget {
  const AddToCartBar({super.key, required this.inStock});

  final bool inStock;

  @override
  State<AddToCartBar> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends State<AddToCartBar> {
  _CartStatus _status = _CartStatus.idle;

  Future<void> _onPressed() async {
    if (_status == _CartStatus.added) {
      setState(() => _status = _CartStatus.idle);
      return;
    }
    setState(() => _status = _CartStatus.adding);
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _status = _CartStatus.added);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    final added = _status == _CartStatus.added;

    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x000A0C11), AppColors.background],
          stops: [0, 0.35],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.xl,
          AppSpacing.m + bottom,
        ),
        child: AppButton(
          label: !widget.inStock
              ? 'Out of stock'
              : added
              ? 'Added to cart'
              : 'Add to cart',
          icon: added ? LucideIcons.check : LucideIcons.shoppingCart,
          loading: _status == _CartStatus.adding,
          onPressed: widget.inStock ? _onPressed : null,
        ),
      ),
    );
  }
}
