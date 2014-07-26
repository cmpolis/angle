#
#
# A simple, single series line chart

class Angle.LineChart

  ###
  ###

  interpolate: 'linear'
  xAccess: (d) -> d[0]
  yAccess: (d) -> d[1]

  ###
  ###

  initialize: (options) ->
    console.log 'init line chart'

    #
    for property in ['interpolate', 'yAccessor', 'xAccessor', 'transform']
      @[property] = options[property] if options[property]?

  ###
  ###

  afterFetch: () ->
    @transform() if  @transform?

    # Build scales
    if @xAccess(@data[0]) instanceof Date
      @xScale = d3.time.scale()
        .range [0, @width]
        .domain d3.extent(@data, @xAccessor)
    else
      @xScale = d3.scale.linear()
        .range [0, @width]
        .domain d3.extent(@data, @xAccessor)
    @yScale = d3.scale.liner()
      .range [@height, 0]
      .domain d3.extent(@data, @yAccessor)

    # Line
    @line = d3.svg.line()
      .interpolate @interpolate
      .x @xAccessor
      .y @yAccessor

  ###
  ###

  render: () ->

    # Render x axis
    @svg.append 'g'
      .attr 'class', 'x axis'
      .call xAxis()

    # Render y axis
    @svg.append 'g'
      .attr 'class', 'y axis'
      .call yAxis()

    # Render data lines
    @svg.append 'path'
      .attr 'd', @line(@data)
