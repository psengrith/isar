MACOSX_DEPLOYMENT_TARGET=12.0
CMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}
IPHONEOS_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}
CXXFLAGS="-mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"

all: format build test

format:
	dart format examples/pub/ packages/isar/ packages/isar_generator/ \
	 packages/isar_test/ packages/isar_web/ packages/isar_flutter_libs/ \
	 packages/isar_inspector/

build:
	cargo build --release
	find target/release/ -maxdepth 1 -type f \
	 \( -name "*.dylib" -o -name "*.so" -o -name "*.dll" \) \
	 -exec cp {} packages/isar_test/ \;

# Unit tests
test:
	cd packages/isar_test && dart run build_runner build --delete-conflicting-outputs \
	 && dart test

clean:
	cargo clean

.PHONY: all clean
