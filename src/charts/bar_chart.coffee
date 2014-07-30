#
#
# A simple, bar chart (equal width bars, no holes)

Angle.BarChart = class Angle.BarChart extends Angle.ChartBase

  ###
  ###

  xAccessor: (d) -> d[0]
  yAccessor: (d) -> d[1]
  barPadding: 2

  ###
  ###

  initialize: (options) =>
    console.log 'init bar chart'

    #
    for property in ['yAccessor', 'xAccessor', 'transform', 'barPadding']
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
    @bars = @svg.selectAll('g')
      .data(@data).enter()
      .append 'g'

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

    #
    barWidth = @width / @data.length
    offset   = barWidth/2 - @barPadding/2
    @bars
      .attr 'transform', (d) => "translate(#{@xScale(@xAccessor(d))-offset},0)"
      .append 'rect'
        .attr 'y',      (d) => @yScale(@yAccessor(d))
        .attr 'height', (d) => @height - @yScale(@yAccessor(d))
        .attr 'width',  barWidth - @barPadding
