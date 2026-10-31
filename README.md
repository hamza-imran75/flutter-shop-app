# Shop app

A Flutter shop client for https://dummyjson.com. It has a login, a paged product list, a product detail page and a local cart.

Phase 1 (this branch) is UI and state against fake repositories. Phase 2 swaps in the real network layer without touching screens or controllers.

## Run

```sh
flutter pub get
flutter run                                  # normal scenario
flutter run --dart-define=FAKE_SCENARIO=slowLoading
```

Scenarios for `FAKE_SCENARIO`: `normal`, `slowLoading`, `error`, `empty`, `offline`, `failLoadMore`. Log in with `emilys` / `emilyspass`. Any other credentials show an inline error.

## Developer panel

Long-press the app title ("Discover" on the list, "Welcome back" on login) to open a bottom sheet. Pick a scenario to change how the fake backend behaves while the app runs. "Connectivity restored" ends the offline scenario, and anything waiting for the network resumes by itself.

To see the offline view, start with `FAKE_SCENARIO=error`, open the panel, choose Offline, then tap "Try again". Choose "Connectivity restored" and the list loads.

## Structure

```
apps/shop_app/lib
  app/        shell, auth gate, route transitions, the override list
  core/       Failure hierarchy, ConnectivityStatus, shared helpers
  dev/        FakeScenario controller and the panel (delete in phase 2)
  features/
    auth/     domain, data (fake), presentation
    products/ domain, data (fake + bundled catalog), presentation
    cart/     domain, data (in memory), presentation
packages/ui_kit   tokens, AppButton, text field, pull to refresh, skeleton,
                  status and offline views, quantity stepper
```

## Decisions

**State management.** `flutter_riverpod` injects dependencies and owns controller lifetimes. `context_watch` watches state in `build`. Controllers are `ValueNotifier`s holding sealed state classes, and widgets call `.watch(context)` on them. Riverpod never rebuilds widgets, and context_watch never creates objects, so no state is observed twice.

**Repositories behind providers.** Screens and controllers see `AuthRepository`, `ProductRepository` and `CartRepository`. `app/overrides.dart` is the only file that names an implementation.

**Typed failures.** `Failure` is sealed: offline, server, unauthorized, invalid credentials, unknown. Controllers emit sealed states such as `ProductListLoading`, `ProductListData`, `ProductListEmpty` and `ProductListError`. Load-more and refresh errors live inside `ProductListData`, so a failed page never discards the list.

**Offline.** `ConnectivityStatus` is an interface in `core/`. `retryWhenOnline` waits for connectivity and then retries, and `OfflineGate` in ui_kit shows the offline view while a screen is loading without a connection.

**Cart.** `Cart` and `CartLine` are immutable. Quantity is capped at stock. `cartQuantityProvider(productId)` derives one listenable per product, so a card or the detail bar rebuilds only when its own quantity changes.

**Accessibility.** Semantics live in ui_kit (buttons, fields, stepper, status views) so screens get them for free. Tap targets are at least 44 points, status changes use live regions, the product grid grows with the text scale, and reduced motion removes the Hero, slide-ins, shimmer and route transitions.

## Phase 2 checklist

1. Add Dio and the generated API client, then implement the three repositories in `features/*/data`.
2. Store tokens securely and add the 401 refresh interceptor.
3. Implement `ConnectivityStatus` with real connectivity and override `connectivityStatusProvider`.
4. Replace the fake entries in `app/overrides.dart` and delete `dev/` and `features/*/data/fake_*`.
