GENERATED_FILES = \
 	angle.js \
 	angle.min.js \
  test/all/all.js \
  test/all/index.html

.PHONY: all test build

all: build

build:
	coffee -cj angle.js src/angle.coffee src/style.coffee src/settings.coffee src/util/*.coffee src/charts/base.coffee src/charts/*_chart.coffee

test:
	sass test/style.sass:test/style.css
	haml test/all/index.haml test/all/index.html
	coffee -c test/all/all.coffee
	open test/all/index.html

clean:
	rm -f -- $(GENERATED_FILES)
