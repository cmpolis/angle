GENERATED_FILES = \
 	angle.js \
 	angle.min.js \
  test/all/all.js \
  test/all/index.html

#
.PHONY: all test clean build

#
all: clean build

#
build:
	@echo
	@echo Building angle.js source files...
	coffee -cj angle.js src/angle.coffee src/style.coffee src/settings.coffee src/util/*.coffee src/charts/base.coffee src/charts/*_chart.coffee src/charts/scatter_plot.coffee

#
test: all
	@echo
	@echo Building test files, then opening in a browser...
	sass test/style.sass:test/style.css
	haml test/all/index.haml test/all/index.html
	coffee -c test/all/all.coffee
	open test/all/index.html

#
clean:
	@echo
	@echo -e \nRemoving generated files: $(GENERATED_FILES)
	rm -f -- $(GENERATED_FILES)
