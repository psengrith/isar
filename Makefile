MACOSX_DEPLOYMENT_TARGET=12.0
CMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}
IPHONEOS_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET}
CXXFLAGS="-mmacosx-version-min=${MACOSX_DEPLOYMENT_TARGET}"

all: format build test

format:
	cd examples/pub/ && dart format .
	cd packages/isar/ && dart format .
	cd packages/isar_generator/ && dart format .
	cd packages/isar_test/ && dart format .
	cd packages/isar_web/ && dart format .
	cd packages/isar_flutter_libs/ && dart format .
	cd packages/isar_inspector/ && dart format .
	dart format .

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
