#!/usr/bin/env bash
# Fails when any source imports Material or Cupertino, or a pubspec pulls in a
# package known to depend on them. The Flutter SDK itself links Cupertino into
# every build (animation/curves.dart imports it), so a built artifact cannot be
# used as evidence. The source and pubspec checks are the contract.
set -euo pipefail
cd "$(dirname "$0")/.."

status=0
pattern="package:flutter/(material|cupertino)\.dart|package:flutter/src/(material|cupertino)/"

hits=$(grep -rnE "$pattern" --include='*.dart' apps packages 2>/dev/null \
  | grep -v '/\.dart_tool/' | grep -v '/build/' || true)
if [ -n "$hits" ]; then
  echo "Material/Cupertino imports found in sources:"
  echo "$hits"
  status=1
fi

banned="uses-material-design:[[:space:]]*true|^[[:space:]]+(flutter_riverpod|hooks_riverpod|go_router|cupertino_icons):"
if grep -rnE "$banned" --include=pubspec.yaml apps packages pubspec.yaml 2>/dev/null; then
  echo "pubspec.yaml enables Material or depends on a banned package"
  status=1
fi

[ "$status" -eq 0 ] && echo "ok: no material or cupertino"
exit "$status"
