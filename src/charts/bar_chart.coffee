#
#
# A simple, bar chart (equal width bars, no holes)

Angle.BarChart = class Angle.BarChart extends Angle.ChartBase

  ###
  ###

  xAccessor: (d) -> d[0]
  yAccessor: (d) -> d[1]
  barPadding: 2
  yMin: 0
  yMax: null
  xMin: 0

  ###
  ###

  initialize: (options) =>
    for property in ['yAccessor', 'xAccessor', 'transform', 'barPadding', 'yMin', 'yMax', 'xMin']
      @[property] = options[property] if options[property]?

  ###
  ###

  afterFetch: () =>
    @transform() if  @transform?

    # Build scales
    if @xAccessor(@data[0]) instanceof Date
      @xScale = x = d3.time.scale()
        .range [0, @width]
        .domain [@xMin, d3.max(@data, @xAccessor)]
    else
      @xScale = x = d3.scale.linear()
        .range  [0, @width]
        .domain [@xMin, d3.max(@data, @xAccessor)]

    yExtent = d3.extent _.union(@data.map(@yAccessor), [@yMin, @yMax])
    @yScale = y = d3.scale.linear()
      .range  [@height, 0]
      .domain yExtent

    # Bar selection
    @bars = @drawLayer.selectAll('g')
      .data(@data).enter()
      .append 'g'

  ###
  ###

  render: () =>

    # Render x axis
    @axisLayer.append 'g'
      .attr 'class', 'x axis'
      .attr 'transform', "translate(0, #{@height})"
      .call @xAxis()

    # Render y axis
    @axisLayer.append 'g'
      .attr 'class', 'y axis'
      .call @yAxis()

    # Render bars
    barWidth = @width / @data.length
    offset   = barWidth/2 - @barPadding/2
    @bars
      .attr 'transform', (d) => "translate(#{@xScale(@xAccessor(d))-offset},0)"
      .append 'rect'
        .attr 'y',      (d) => @yScale(@yAccessor(d))
        .attr 'height', (d) => @height - @yScale(@yAccessor(d))
        .attr 'width',  barWidth - @barPadding
