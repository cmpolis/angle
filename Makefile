GENERATED_FILES = \
 	angle.js \
 	angle.min.js \
 	js

all: build

build:
	coffee -cj angle.js src/angle.coffee src/style.coffee src/util/*.coffee src/charts/base.coffee src/charts/*_chart.coffee

test:
	open test/all/index.html

clean:
	rm -f -- $(GENERATED_FILES)
