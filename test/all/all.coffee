#
#
#

test = () ->

  #
  @barChart = new Angle.BarChart
    el: '#bar-chart'
    height: 360
    width: 720
    data: [[1,30],[2,50],[3,35],[4,40],[5,52]]

  #
  @lineChart = new Angle.LineChart
    el: '#line-chart'
    height: 360
    width: 720
    data: [[1,30],[2,50],[3,35],[4,40],[5,52]]

  ###
  #
  @ohlcChart = new Angle.OHLCChart
    el: '#ohlc-chart'
    data: []

  #
  @scatterPlot = new Angle.ScatterPlot
    el: '#scatter-plot'
    data: []

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
