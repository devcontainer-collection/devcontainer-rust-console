#!/bin/bash

set -e

SCRIPT_NAME=$(basename "$0")

trap 'echo "Exit $SCRIPT_NAME"' EXIT
echo "Running $SCRIPT_NAME..."

if [ ! -f "/.dockerenv" ]; then
  echo "$SCRIPT_NAME: This script is only for use in a devcontainer."
  exit 0
fi

SCRIPT_NAME=$(basename "$0")
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_DIR="$SCRIPT_DIR/.."
SRC_DIR="$APP_DIR/src"
cd "$APP_DIR" || exit 1

# Usage:
# sh build.sh --arch <arch> [--vendor <vendor>] --os <os> [--abi <abi>] --build-type <debug|release>
# Example:
# sh build.sh --arch x86_64 --os linux --build-type release

# --- Parse named args ---
while [ $# -gt 0 ]; do
  case "$1" in
    --arch)
      ARCH="$2"
      shift 2
      ;;
    --vendor)
      VENDOR="$2"
      shift 2
      ;;
    --os)
      OS="$2"
      shift 2
      ;;
    --abi)
      ABI="$2"
      shift 2
      ;;
    --build-type)
      BUILD_TYPE="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

# --- Set defaults if needed ---
[ -z "$VENDOR" ] && VENDOR="unknown"
# [ -z "$ABI" ] && ABI="gnu"
[ -z "$BUILD_TYPE" ] && BUILD_TYPE="debug"

# --- Validate ---
if [ -z "$ARCH" ] || [ -z "$OS" ]; then
  echo "Usage: $0 --arch <arch> [--vendor <vendor>] --os <os> [--abi <abi>] [--build-type <debug|release>]"
  exit 1
fi

# Extract the crate name from Cargo.toml.
CARGO_TOML_FULL_PATH="$APP_DIR/Cargo.toml"
if [ ! -f "$CARGO_TOML_FULL_PATH" ]; then
  echo "Cargo.toml not found: $CARGO_TOML_FULL_PATH"
  exit 1
fi
# CRATE_NAME=$(grep '^name' $CARGO_TOML_FULL_PATH | head -n1 | cut -d '"' -f2)
BINARY_NAME=main
BINARY_NAME_WITH_EXT=$BINARY_NAME
if [ "$OS" = "windows" ]; then
  BINARY_NAME_WITH_EXT="$BINARY_NAME.exe"
fi

# make target triple
if [ -z "$ABI" ]; then
  TARGET_TRIPLE="$ARCH-$VENDOR-$OS"
  # ex) x86_64-apple-darwin
else
  TARGET_TRIPLE="$ARCH-$VENDOR-$OS-$ABI"
  # ex) x86_64-unknown-linux-gnu
fi

TARGET_DIR="$APP_DIR/target"
# BUILDTYPE_ARCH_VENDOR_OS_ABI_PATH="$APP_DIR/build/${BUILD_TYPE}/$TARGET_TRIPLE"

# OUTPUT="${BUILDTYPE_ARCH_VENDOR_OS_ABI_PATH}/${BASENAME}"

# mkdir -p ${BUILDTYPE_ARCH_VENDOR_OS_ABI_PATH}

# Determine the build mode
if [ "$BUILD_TYPE" = "release" ]; then
    echo "[build] Release build"
    cargo zigbuild \
        --manifest-path "$CARGO_TOML_FULL_PATH" \
        --bin "$BINARY_NAME" \
        --target-dir "$TARGET_DIR" \
        --target "$TARGET_TRIPLE" \
        --$BUILD_TYPE
elif [ "$BUILD_TYPE" = "debug" ]; then
    echo "[build] Debug build"
    cargo zigbuild \
        --manifest-path "$CARGO_TOML_FULL_PATH" \
        --bin "$BINARY_NAME" \
        --target-dir "$TARGET_DIR" \
        --target "$TARGET_TRIPLE"
else
    echo "Unsupported build type: $BUILD_TYPE"
    exit 1
fi

echo "[build] Build completed"

# # if release build, strip the binary
# # but no need to cargo zigbuild --release, because it is already done, except darwin...
# if [ "$BUILD_TYPE" = "release" ]; then
#     echo "[build] Stripping binary..."
#     # echo "call strip with '$TARGET_TRIPLE'"
#     # echo "[build] Binary: $TARGET_DIR/$TARGET_TRIPLE/release/$BINARY_NAME_WITH_EXT"
#     bash "$SCRIPT_DIR/strip.sh" --bin "$TARGET_DIR/$TARGET_TRIPLE/release/$BINARY_NAME_WITH_EXT" --target-triple "$TARGET_TRIPLE"
# fi
if [ "$BUILD_TYPE" = "release" ] && { [ "$OS" = "macos" ] || [ "$OS" = "darwin" ]; }; then
  echo "[build] Note: macOS binaries are not stripped automatically. Please run 'strip' on each binary manually on a macOS system that matches the target architecture."
fi
