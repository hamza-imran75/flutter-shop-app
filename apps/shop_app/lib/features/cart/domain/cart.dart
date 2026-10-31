import '../../products/domain/product.dart';

class CartLine {
  const CartLine({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  bool get canIncrement => quantity < product.stock;

  double get listTotal => product.price * quantity;

  double get total =>
      (product.hasDiscount ? product.discountedPrice : product.price) *
      quantity;

  CartLine withQuantity(int value) =>
      CartLine(product: product, quantity: value);
}

class Cart {
  Cart(List<CartLine> lines) : lines = List.unmodifiable(lines);

  static final empty = Cart(const []);

  final List<CartLine> lines;

  bool get isEmpty => lines.isEmpty;

  int get itemCount => lines.fold(0, (sum, l) => sum + l.quantity);

  double get subtotal => lines.fold(0, (sum, l) => sum + l.listTotal);

  double get total => lines.fold(0, (sum, l) => sum + l.total);

  double get savings => subtotal - total;

  int quantityOf(int productId) {
    for (final line in lines) {
      if (line.product.id == productId) return line.quantity;
    }
    return 0;
  }

  /// Adds one unit, never beyond the product's stock.
  Cart add(Product product) {
    final current = quantityOf(product.id);
    if (current >= product.stock) return this;
    return current == 0
        ? Cart([...lines, CartLine(product: product, quantity: 1)])
        : setQuantity(product.id, current + 1);
  }

  /// A quantity of zero or less removes the line.
  Cart setQuantity(int productId, int quantity) {
    if (quantity <= 0) return remove(productId);
    return Cart([
      for (final line in lines)
        line.product.id == productId
            ? line.withQuantity(quantity.clamp(1, line.product.stock))
            : line,
    ]);
  }

  Cart remove(int productId) =>
      Cart(lines.where((l) => l.product.id != productId).toList());
}
