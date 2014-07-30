#
#
# A simple, single series line chart

Angle.LineChart = class Angle.LineChart extends Angle.ChartBase

  ###
  ###

  interpolate: 'linear'
  xAccessor: (d) -> d[0]
  yAccessor: (d) -> d[1]
  yMin: null # force y axis top/bottom
  yMax: null

  ###
  ###

  initialize: (options) =>
    for property in ['interpolate', 'yAccessor', 'xAccessor', 'transform', 'yMin', 'yMax']
      @[property] = options[property] if options[property]?

  ###
  ###

  afterFetch: () =>
    @transform() if  @transform?

    # Build scales
    if @xAccessor(@data[0]) instanceof Date
      @xScale = x = d3.time.scale()
        .range  [0, @width]
        .domain d3.extent(@data, @xAccessor)
    else
      @xScale = x = d3.scale.linear()
        .range  [0, @width]
        .domain d3.extent(@data, @xAccessor)

    #
    yExtent = d3.extent _.union(@data.map(@yAccessor), [@yMin, @yMax])
    @yScale = y = d3.scale.linear()
      .range  [@height, 0]
      .domain yExtent

    # Line
    @line = d3.svg.line()
      .interpolate @interpolate
      .x (d) => x(@xAccessor(d))
      .y (d) => y(@yAccessor(d))

  ###
  ###

  render: () =>

    # Render x axis
    @svg.append 'g'
      .attr 'class', 'x axis'
      .attr 'transform', "translate(0, #{@height})"
      .call @xAxis()

    # Render y axis
    @svg.append 'g'
      .attr 'class', 'y axis'
      .call @yAxis()

    # Render data lines
    @svg.append 'path'
      .attr 'd', @line(@data)
