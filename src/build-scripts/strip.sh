#!/bin/bash

# Script to strip debug symbols from the binary created by Rust.

set -e

TARGET_TRIPLE="$1"
# TARGET_TRIPLE allows the following values:
# native,
# x86_64-unknown-linux-gnu,
# aarch64-unknown-linux-gnu,
# x86_64-apple-darwin,
# aarch64-apple-darwin,
# x86_64-pc-windows-gnu,
# aarch64-pc-windows-gnu.

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Extract the crate name from Cargo.toml.
CRATE_NAME=$(grep '^name' $SCRIPT_DIR/../Cargo.toml | head -n1 | cut -d '"' -f2)
BIN_PATH="target/$TARGET_TRIPLE/release/$CRATE_NAME"

echo "[strip] Target: $TARGET_TRIPLE"
echo "[strip] Binary: $BIN_PATH"

if [ ! -f "$BIN_PATH" ]; then
  echo "Executable not found: $BIN_PATH"
  exit 1
fi

# Switch strip command based on target triple.
case "$TARGET_TRIPLE" in
  native)
    strip "$BIN_PATH"
    echo "$BIN_PATH stripped"
    ;;
  x86_64-unknown-linux-gnu)
    x86_64-linux-gnu-strip "$BIN_PATH"
    echo "$BIN_PATH stripped"
    ;;
  aarch64-unknown-linux-gnu)
    aarch64-linux-gnu-strip "$BIN_PATH"
    echo "$BIN_PATH stripped"
    ;;
  x86_64-apple-darwin | aarch64-apple-darwin)
    echo "Stripping macOS binaries is not supported."
    echo "Please use 'strip' on macOS manually."
    ;;
  x86_64-pc-windows-gnu)
    x86_64-w64-mingw32-strip "$BIN_PATH"
    echo "$BIN_PATH stripped"
    ;;
  aarch64-pc-windows-gnu)
    aarch64-w64-mingw32-strip "$BIN_PATH"
    echo "$BIN_PATH stripped"
    ;;
  *)
    echo "Stripping is not supported for target triple: $TARGET_TRIPLE"
    ;;
esac
