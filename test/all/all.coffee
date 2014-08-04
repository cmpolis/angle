#
#
#

test = () ->

  #
  colorTests = [0...36].map (ndx) ->
    d3.select '#palette'
      .append 'div'
        .style 'background-color', Angle.color(ndx)
        .style 'height', '50px'
        .style 'width', '50px'
        .style 'display', 'inline-block'

  #
  @barChart = new Angle.BarChart
    el:     '#bar-chart'
    height: 360
    width:  720
    data:   [[1,30],[2,50],[3,35],[4,40],[5,52],
             [6,30],[7,50],[8,35],[9,40],[10,52]]

  #
  @lineChart = new Angle.LineChart
    el:     '#line-chart'
    height: 360
    width:  720
    yMin:   0
    grid:   true
    data:   [[1,30],[2,50],[3,35],[4,40],[5,52],
             [6,30],[7,50],[8,35],[9,40],[10,52]]

  ###
  #
  @ohlcChart = new Angle.OHLCChart
    el: '#ohlc-chart'
    data: []
  ###

  #
  @scatterPlot = new Angle.ScatterPlot
    el: '#scatter-plot'
    height: 360
    width:  720
    data:   [[1,30],[2,50],[3,35],[4,40],[5,52]]

  ###

  #
  @slopeograph = new Angle.Slopeograph
    el: '#slopeograph'
    data: []

  #
  @sparkline = new Angle.Sparkline
    el: '#sparkline'
    data: []
  ###

test()
