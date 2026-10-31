import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/overrides.dart';
import 'core/provider_scope.dart';

void main() {
  runApp(ProviderScope(overrides: appOverrides(), child: const ShopApp()));
}
