// Generated by CoffeeScript 1.7.1
(function() {
  var _Style,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Angle = {};

  Angle.style = new (_Style = (function() {
    function _Style() {
      this._color = __bind(this._color, this);
    }

    _Style.prototype.palette = ["#5B5874", "#82D148", "#CF513A", "#C059CC", "#517240", "#D0B44D", "#80BEC7", "#BA4A7E", "#8AD59B", "#CFA8A9", "#86573A", "#7C7DCB"];

    _Style.prototype._color = function(ndx) {
      if (ndx == null) {
        ndx = Math.floor(Math.random() * this.palette.length);
      }
      if (ndx < this.palette.length) {
        return this.palette[ndx];
      } else if (ndx < this.palette.length * 2) {
        return d3.rgb(this.palette[ndx % this.palette.length]).brighter().toString();
      } else if (ndx < this.palette.length * 3) {
        return d3.rgb(this.palette[ndx % this.palette.length]).darker().toString();
      } else {
        return this.color(ndx % (this.palette.length * 3));
      }
    };

    return _Style;

  })());

  Angle.color = Angle.style._color;

  Angle.settings = {};

  console.log('/util dir');

  Angle.ChartBase = Angle.ChartBase = (function() {
    ChartBase.prototype.padding = {
      top: 40,
      right: 40,
      bottom: 40,
      left: 40
    };

    ChartBase.prototype.height = 600;

    ChartBase.prototype.width = 600;


    /*
     */

    function ChartBase(options) {
      var elHeight, elWidth;
      if (options == null) {
        options = {};
      }
      this.render = __bind(this.render, this);
      this.yAxis = __bind(this.yAxis, this);
      this.xAxis = __bind(this.xAxis, this);
      this.fetch = __bind(this.fetch, this);
      this.fetchOrRender = __bind(this.fetchOrRender, this);
      if (!(options.el && (this.el = d3.select(options.el)))) {
        throw "DOM Element not found, pass in a valid selector as `el`";
      }
      if (Angle.settings.padding != null) {
        _.extend(this.padding, Angle.settings.padding);
      }
      if (options.padding != null) {
        _.extend(this.padding, options);
      }
      if (options.height) {
        this.height = options.height;
      } else if ((elHeight = parseInt(this.el.style('height'))) > 0) {
        this.height = elHeight;
      } else if (Angle.settings.height != null) {
        this.height = Angle.settings.height;
      }
      if (options.width) {
        this.width = options.width;
      } else if ((elWidth = parseInt(this.el.style('width'))) > 0) {
        this.width = elWidth;
      } else if (Angle.settings.width != null) {
        this.width = Angle.settings.width;
      }
      this.svg = this.el.append('svg').style({
        height: this.height,
        width: this.width
      }).append('g').attr('transform', "translate(" + this.padding.left + "," + this.padding.top + ")");
      this.width = this.width - this.padding.right - this.padding.left;
      this.height = this.height - this.padding.top - this.padding.bottom;
      if (this.initialize != null) {
        this.initialize(options);
      }
      this.render = _.wrap(this.render, (function(_this) {
        return function(renderFunc) {
          renderFunc();
          if (_this.afterRender != null) {
            return _this.afterRender(_this);
          }
        };
      })(this));
      this.fetchOrRender(options.data);
    }


    /*
     */

    ChartBase.prototype.fetchOrRender = function(data) {
      if (typeof data === 'object') {
        this.data = data;
        if (this.afterFetch != null) {
          this.afterFetch();
        }
        return this.render();
      } else if (typeof data === 'string') {
        return this.fetch(data, function() {
          return this.render();
        });
      }
    };


    /*
     */

    ChartBase.prototype.fetch = function(url, next) {
      var extension;
      this.dataUrl = data;
      extension = this.dataUrl.match(/\.[0-9a-z]+$/i)[0].toLowerCase();
      if (!_.contains("text json xml csv tsv".split(' '), extension)) {
        throw "Data url has invalid extension: " + extension;
      }
      return d3[extension](this.dataUrl, (function(_this) {
        return function(error, data) {
          if (error != null) {
            throw error;
          }
          _this.data = data;
          if (_this.afterFetch != null) {
            _this.afterFetch();
          }
          if (_this.next != null) {
            return _this.next();
          }
        };
      })(this));
    };


    /*
     */

    ChartBase.prototype.xAxis = function(options) {
      if (options == null) {
        options = {};
      }
      options = _.extend(options, {
        orientation: 'bottom',
        scale: this.xScale,
        ticks: 10
      });
      return d3.svg.axis().scale(options.scale).ticks(options.ticks).orient(options.orientation);
    };

    ChartBase.prototype.yAxis = function(options) {
      if (options == null) {
        options = {};
      }
      options = _.extend(options, {
        orientation: 'left',
        scale: this.yScale,
        ticks: 10
      });
      return d3.svg.axis().scale(options.scale).ticks(options.ticks).orient(options.orientation);
    };


    /*
     */

    ChartBase.prototype.render = function() {
      throw "render() not implemented";
    };

    return ChartBase;

  })();

  Angle.BarChart = Angle.BarChart = (function(_super) {
    __extends(BarChart, _super);

    function BarChart() {
      this.render = __bind(this.render, this);
      this.afterFetch = __bind(this.afterFetch, this);
      this.initialize = __bind(this.initialize, this);
      return BarChart.__super__.constructor.apply(this, arguments);
    }


    /*
     */

    BarChart.prototype.xAccessor = function(d) {
      return d[0];
    };

    BarChart.prototype.yAccessor = function(d) {
      return d[1];
    };

    BarChart.prototype.barPadding = 2;

    BarChart.prototype.yMin = 0;

    BarChart.prototype.yMax = null;


    /*
     */

    BarChart.prototype.initialize = function(options) {
      var property, _i, _len, _ref, _results;
      _ref = ['yAccessor', 'xAccessor', 'transform', 'barPadding', 'yMin', 'yMax'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        property = _ref[_i];
        if (options[property] != null) {
          _results.push(this[property] = options[property]);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };


    /*
     */

    BarChart.prototype.afterFetch = function() {
      var x, y, yExtent;
      if (this.transform != null) {
        this.transform();
      }
      if (this.xAccessor(this.data[0]) instanceof Date) {
        this.xScale = x = d3.time.scale().range([0, this.width]).domain(d3.extent(this.data, this.xAccessor));
      } else {
        this.xScale = x = d3.scale.linear().range([0, this.width]).domain(d3.extent(this.data, this.xAccessor));
      }
      yExtent = d3.extent(_.union(this.data.map(this.yAccessor), [this.yMin, this.yMax]));
      this.yScale = y = d3.scale.linear().range([this.height, 0]).domain(yExtent);
      return this.bars = this.svg.selectAll('g').data(this.data).enter().append('g');
    };


    /*
     */

    BarChart.prototype.render = function() {
      var barWidth, offset;
      this.svg.append('g').attr('class', 'x axis').attr('transform', "translate(0, " + this.height + ")").call(this.xAxis());
      this.svg.append('g').attr('class', 'y axis').call(this.yAxis());
      barWidth = this.width / this.data.length;
      offset = barWidth / 2 - this.barPadding / 2;
      return this.bars.attr('transform', (function(_this) {
        return function(d) {
          return "translate(" + (_this.xScale(_this.xAccessor(d)) - offset) + ",0)";
        };
      })(this)).append('rect').attr('y', (function(_this) {
        return function(d) {
          return _this.yScale(_this.yAccessor(d));
        };
      })(this)).attr('height', (function(_this) {
        return function(d) {
          return _this.height - _this.yScale(_this.yAccessor(d));
        };
      })(this)).attr('width', barWidth - this.barPadding);
    };

    return BarChart;

  })(Angle.ChartBase);

  Angle.LineChart = Angle.LineChart = (function(_super) {
    __extends(LineChart, _super);

    function LineChart() {
      this.render = __bind(this.render, this);
      this.afterFetch = __bind(this.afterFetch, this);
      this.initialize = __bind(this.initialize, this);
      return LineChart.__super__.constructor.apply(this, arguments);
    }


    /*
     */

    LineChart.prototype.interpolate = 'linear';

    LineChart.prototype.xAccessor = function(d) {
      return d[0];
    };

    LineChart.prototype.yAccessor = function(d) {
      return d[1];
    };

    LineChart.prototype.yMin = null;

    LineChart.prototype.yMax = null;


    /*
     */

    LineChart.prototype.initialize = function(options) {
      var property, _i, _len, _ref, _results;
      _ref = ['interpolate', 'yAccessor', 'xAccessor', 'transform', 'yMin', 'yMax'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        property = _ref[_i];
        if (options[property] != null) {
          _results.push(this[property] = options[property]);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };


    /*
     */

    LineChart.prototype.afterFetch = function() {
      var x, y, yExtent;
      if (this.transform != null) {
        this.transform();
      }
      if (this.xAccessor(this.data[0]) instanceof Date) {
        this.xScale = x = d3.time.scale().range([0, this.width]).domain(d3.extent(this.data, this.xAccessor));
      } else {
        this.xScale = x = d3.scale.linear().range([0, this.width]).domain(d3.extent(this.data, this.xAccessor));
      }
      yExtent = d3.extent(_.union(this.data.map(this.yAccessor), [this.yMin, this.yMax]));
      this.yScale = y = d3.scale.linear().range([this.height, 0]).domain(yExtent);
      return this.line = d3.svg.line().interpolate(this.interpolate).x((function(_this) {
        return function(d) {
          return x(_this.xAccessor(d));
        };
      })(this)).y((function(_this) {
        return function(d) {
          return y(_this.yAccessor(d));
        };
      })(this));
    };


    /*
     */

    LineChart.prototype.render = function() {
      this.svg.append('g').attr('class', 'x axis').attr('transform', "translate(0, " + this.height + ")").call(this.xAxis());
      this.svg.append('g').attr('class', 'y axis').call(this.yAxis());
      return this.svg.append('path').attr('d', this.line(this.data));
    };

    return LineChart;

  })(Angle.ChartBase);

  Angle.OHLCChart = (function() {

    /*
     */
    function OHLCChart() {}

    return OHLCChart;

  })();

  Angle.ScatterPlot = Angle.ScatterPlot = (function(_super) {
    __extends(ScatterPlot, _super);

    function ScatterPlot() {
      this.render = __bind(this.render, this);
      this.afterFetch = __bind(this.afterFetch, this);
      this.initialize = __bind(this.initialize, this);
      return ScatterPlot.__super__.constructor.apply(this, arguments);
    }


    /*
     */

    ScatterPlot.prototype.xAccessor = function(d) {
      return d[0];
    };

    ScatterPlot.prototype.yAccessor = function(d) {
      return d[1];
    };

    ScatterPlot.prototype.radius = function(d) {
      return 4.5;
    };


    /*
     */

    ScatterPlot.prototype.initialize = function(options) {
      var property, _i, _len, _ref, _results;
      console.log('init scatter plot');
      _ref = ['yAccessor', 'xAccessor', 'transform', 'radius'];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        property = _ref[_i];
        if (options[property] != null) {
          _results.push(this[property] = options[property]);
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };


    /*
     */

    ScatterPlot.prototype.afterFetch = function() {
      var x, y;
      if (this.transform != null) {
        this.transform();
      }
      if (this.xAccessor(this.data[0]) instanceof Date) {
        this.xScale = x = d3.time.scale().range([0, this.width]).domain(d3.extent(this.data, this.xAccessor));
      } else {
        this.xScale = x = d3.scale.linear().range([0, this.width]).domain(d3.extent(this.data, this.xAccessor));
      }
      this.yScale = y = d3.scale.linear().range([this.height, 0]).domain(d3.extent(this.data, this.yAccessor));
      return this.points = this.svg.selectAll('g').data(this.data).enter().append('g');
    };


    /*
     */

    ScatterPlot.prototype.render = function() {
      this.svg.append('g').attr('class', 'x axis').attr('transform', "translate(0, " + this.height + ")").call(this.xAxis());
      this.svg.append('g').attr('class', 'y axis').call(this.yAxis());
      return this.points.append('circle').attr('r', (function(_this) {
        return function(d) {
          return _this.radius(d);
        };
      })(this)).attr('cx', (function(_this) {
        return function(d) {
          return _this.xScale(_this.xAccessor(d));
        };
      })(this)).attr('cy', (function(_this) {
        return function(d) {
          return _this.yScale(_this.yAccessor(d));
        };
      })(this));
    };

    return ScatterPlot;

  })(Angle.ChartBase);

}).call(this);
