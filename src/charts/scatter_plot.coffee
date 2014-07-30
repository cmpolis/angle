#
#
# A simple scatter plot

Angle.ScatterPlot = class Angle.ScatterPlot extends Angle.ChartBase

  ###
  ###

  xAccessor: (d) -> d[0]
  yAccessor: (d) -> d[1]
  radius:    (d) -> 4.5

  ###
  ###

  initialize: (options) =>
    console.log 'init scatter plot'

    #
    for property in ['yAccessor', 'xAccessor', 'transform', 'radius']
      @[property] = options[property] if options[property]?

  ###
  ###

  afterFetch: () =>
    @transform() if  @transform?

    # Build scales
    if @xAccessor(@data[0]) instanceof Date
      @xScale = x = d3.time.scale()
        .range [0, @width]
        .domain d3.extent(@data, @xAccessor)
    else
      @xScale = x = d3.scale.linear()
        .range  [0, @width]
        .domain d3.extent(@data, @xAccessor)
    @yScale = y = d3.scale.linear()
      .range  [@height, 0]
      .domain d3.extent(@data, @yAccessor)

    # Bar selection
    @points = @svg.selectAll 'g'
      .data(@data).enter()
      .append 'g'

  ###
  ###

  render: () =>

    # Render x axis
    @svg.append('g')
      .attr 'class', 'x axis'
      .attr 'transform', "translate(0, #{@height})"
      .call @xAxis()

    # Render y axis
    @svg.append('g')
      .attr 'class', 'y axis'
      .call @yAxis()

    #
    @points
      .append 'circle'
        .attr 'r',    (d) => @radius(d)
        .attr 'fill', Angle.color(0)
        .attr 'cx',   (d) => @xScale(@xAccessor(d))
        .attr 'cy',   (d) => @yScale(@yAccessor(d))
