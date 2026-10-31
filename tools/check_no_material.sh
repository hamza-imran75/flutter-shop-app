#!/usr/bin/env bash
# Usage: tools/check_no_material.sh [--artifact path/to/kernel_blob.bin]
# Default mode greps sources. --artifact also scans a built app's kernel so
# transitive dependencies are covered.
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

if grep -rnE "uses-material-design:\s*true" --include=pubspec.yaml apps packages >/dev/null 2>&1; then
  echo "pubspec.yaml enables uses-material-design"
  status=1
fi

if [ "${1:-}" = "--artifact" ]; then
  blob="${2:?path to kernel_blob.bin required}"
  if [ ! -f "$blob" ]; then
    echo "artifact not found: $blob"
    exit 2
  fi
  widgets=$(strings "$blob" | grep -c 'package:flutter/src/widgets/' || true)
  leaked=$(strings "$blob" | grep -E 'package:flutter/src/(material|cupertino)/' | sort -u || true)
  if [ "$widgets" -eq 0 ]; then
    echo "sanity check failed: no widgets-layer paths in artifact"
    exit 2
  fi
  if [ -n "$leaked" ]; then
    echo "Material/Cupertino libraries present in the built app:"
    echo "$leaked" | head -20
    status=1
  fi
fi

[ "$status" -eq 0 ] && echo "ok: no material or cupertino"
exit "$status"
