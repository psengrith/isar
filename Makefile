all: build test

build:
	cargo build --release
	find target/release/ -maxdepth 1 -type f \
	 \( -name "*.dylib" -o -name "*.so" -o -name "*.dll" \) \
	 -exec cp {} packages/isar_test/ \;

test:
	cd packages/isar_test && dart test

clean:
	cargo clean

.PHONY: all clean
