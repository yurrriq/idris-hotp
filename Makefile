IDRIS := idris
PKG   := hotp

.PHONY: build clean clean-all install rebuild doc doc-clean lib

build:
	@$(IDRIS) --build $(PKG).ipkg

clean:
	@cargo clean
	@find . -name '*.ibc' -delete
	@rm -f hotp
	@make -C src -f hotp.mk clean

clean-all: clean doc-clean

install:
	@$(IDRIS) --install $(PKG).ipkg

rebuild: clean build

doc:
	@$(IDRIS) --mkdoc $(PKG).ipkg

doc-clean:
	@rm -rf $(PKG)_doc

hotp: src/Main.idr
	@idris -i src -i target/release src/Main.idr -o hotp

lib: src/lib.rs src/hotp.h
	@cargo build --release
