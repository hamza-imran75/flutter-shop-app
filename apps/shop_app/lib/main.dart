import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/overrides.dart';

void main() {
  runApp(ProviderScope(overrides: appOverrides(), child: const ShopApp()));
}
