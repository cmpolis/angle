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
    for property in ['yAccessor', 'xAccessor', 'transform', 'radius', 'grid']
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
    @points = @drawLayer.selectAll 'g'
      .data(@data).enter()
      .append 'g'

  ###
  ###

  render: () =>

    # Render x axis
    @axisLayer.append('g')
      .attr 'class', 'x axis'
      .attr 'transform', "translate(0, #{@height})"
      .call @xAxis()

    # Render y axis
    @axisLayer.append('g')
      .attr 'class', 'y axis'
      .call @yAxis()

    # Render points
    @points
      .append 'circle'
        .attr 'r',    (d) => @radius(d)
        .attr 'cx',   (d) => @xScale(@xAccessor(d))
        .attr 'cy',   (d) => @yScale(@yAccessor(d))

    # Render grid
    if @grid
      @gridLayer.append 'g'
        .attr 'class', 'grid x'
          .call @xAxis().tickSize(@height, 0, 0).tickFormat('')
      @gridLayer.append 'g'
        .attr 'class', 'grid y'
          .call @yAxis().tickSize(@width, 0, 0).tickFormat('').orient('right')
