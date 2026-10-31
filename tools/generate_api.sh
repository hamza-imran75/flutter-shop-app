#!/usr/bin/env bash
# Regenerates packages/dummyjson_api from its committed spec.
#   tools/generate_api.sh            regenerate from spec/dummyjson.json
#   tools/generate_api.sh --refresh  re-download and re-trim the upstream spec first
set -euo pipefail
cd "$(dirname "$0")/.."
pkg=packages/dummyjson_api
spec=$pkg/spec/dummyjson.json

if [ "${1:-}" = "--refresh" ]; then
  python3 tools/trim_spec.py "$spec"
fi

# pubspec.yaml, build.yaml and analysis_options.yaml are owned by hand: the generator would pin old
# dependency ranges and make json_serializable reject unknown response keys.
keep=$(mktemp -d)
cp "$pkg/pubspec.yaml" "$pkg/build.yaml" "$pkg/analysis_options.yaml" "$keep/"
rm -rf "$pkg/lib" "$pkg/.openapi-generator"
npx --yes @openapitools/openapi-generator-cli generate \
  -g dart-dio \
  -i "$spec" \
  -o "$pkg" \
  --global-property apiTests=false,modelTests=false,apiDocs=false,modelDocs=false \
  --additional-properties=pubName=dummyjson_api,pubLibrary=dummyjson_api,serializationLibrary=json_serializable
cp "$keep/pubspec.yaml" "$keep/build.yaml" "$keep/analysis_options.yaml" "$pkg/"
rm -rf "$keep" "$pkg/README.md" "$pkg/.gitignore" "$pkg/.openapi-generator-ignore" "$pkg/pubspec.lock"

( cd "$pkg" && dart pub get && dart run build_runner build --delete-conflicting-outputs )
dart format "$pkg/lib" >/dev/null
