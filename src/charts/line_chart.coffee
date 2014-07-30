#
#
# A simple, single series line chart

Angle.LineChart = class Angle.LineChart extends Angle.ChartBase

  ###
  ###

  interpolate: 'linear'
  xAccessor: (d) -> d[0]
  yAccessor: (d) -> d[1]

  ###
  ###

  initialize: (options) =>
    console.log 'init line chart'

    #
    for property in ['interpolate', 'yAccessor', 'xAccessor', 'transform']
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
    @yScale = y = d3.scale.linear()
      .range  [@height, 0]
      .domain d3.extent(@data, @yAccessor)

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
