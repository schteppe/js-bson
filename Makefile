NODE = node
NPM = npm
NODEUNIT = node_modules/nodeunit/bin/nodeunit
name = all
BUNDLE_FILES = lib/bson/binary_parser.js lib/bson/code.js lib/bson/db_ref.js lib/bson/double.js lib/bson/float_parser.js lib/bson/long.js lib/bson/max_key.js lib/bson/min_key.js lib/bson/objectid.js lib/bson/symbol.js lib/bson/timestamp.js lib/bson/bson.js lib/bson/binary.js
BUNDLED = bundled/bson.js
BUNDLED_AND_MINIFIED = bundled/bson.min.js

total: build_native

test: build_native
	$(NODEUNIT) ./test/node
	TEST_NATIVE=TRUE $(NODEUNIT) ./test/node

build_native:
	$(MAKE) -C ./ext all

build_native_debug:
	$(MAKE) -C ./ext all_debug

build_native_clang:
	$(MAKE) -C ./ext clang

build_native_clang_debug:
	$(MAKE) -C ./ext clang_debug

bundle:
	cat $(BUNDLE_FILES) > $(BUNDLED)

minify: bundle
	./node_modules/.bin/uglifyjs -o $(BUNDLED_AND_MINIFIED) $(BUNDLED)

clean_native:
	$(MAKE) -C ./ext clean

clean:
	rm ./ext/bson.node
	rm -r ./ext/build

.PHONY: total
