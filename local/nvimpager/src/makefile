DESTDIR ?=
PREFIX ?= /usr/local
RUNTIME = $(PREFIX)/share/nvimpager/runtime
VERSION = $(lastword $(shell ./nvimpager -v))
BUSTED = busted

%.configured: %
	sed 's#^RUNTIME=.*$$#RUNTIME='"'$(RUNTIME)'"'#;s#version=.*$$#version=$(VERSION)#' < $< > $@
	chmod +x $@

install: nvimpager.configured nvimpager.1
	mkdir -p $(DESTDIR)$(PREFIX)/bin $(DESTDIR)$(RUNTIME)/lua \
	  $(DESTDIR)$(PREFIX)/share/man/man1 \
	  $(DESTDIR)$(PREFIX)/share/zsh/site-functions
	install nvimpager.configured $(DESTDIR)$(PREFIX)/bin/nvimpager
	install -m 644 lua/nvimpager.lua $(DESTDIR)$(RUNTIME)/lua
	install -m 644 nvimpager.1 $(DESTDIR)$(PREFIX)/share/man/man1
	install -m 644 _nvimpager $(DESTDIR)$(PREFIX)/share/zsh/site-functions
uninstall:
	$(RM) $(PREFIX)/bin/nvimpager $(RUNTIME)/lua/nvimpager.lua \
	  $(PREFIX)/share/man/man1/nvimpager.1 \
	  $(PREFIX)/share/zsh/site-functions/_nvimpager

nvimpager.1: SOURCE_DATE_EPOCH = $(shell git log -1 --no-show-signature --pretty="%ct" 2>/dev/null || echo 1636921311)
nvimpager.1: nvimpager.md
	sed '1s/$$/ "nvimpager $(VERSION)"/' $< | scdoc > $@

test:
	@$(BUSTED) test
luacov.stats.out: nvimpager lua/nvimpager.lua test/nvimpager_spec.lua
	@$(BUSTED) --coverage test
luacov.report.out: luacov.stats.out
	luacov lua/nvimpager.lua

TYPE = minor
version:
	[ $(TYPE) = major ] || [ $(TYPE) = minor ] || [ $(TYPE) = patch ]
	sed -i 's/version=.*version=/version=/' nvimpager
	awk -i inplace -F '[v.]' -v type=$(TYPE)\
	  -e 'type == "major" && /version=/ { print $$1 "version=v" $$3+1 ".0" }' \
	  -e 'type == "minor" && /version=/ { print $$1 "version=v" $$3 "." $$4+1 }' \
	  -e 'type == "patch" && /version=/ { print $$1 "version=v" $$3 "." $$4 "." $$5+1 }' \
	  -e '/version=/ { next }' \
	  -e '{ print $$0 }' nvimpager
	sed -i "/SOURCE_DATE_EPOCH/s/[0-9]\{10,\}/$(shell date +%s)/" $(MAKEFILE_LIST)

clean:
	$(RM) nvimpager.configured nvimpager.1 luacov.*
.PHONY: clean install test uninstall version
