#
#
#

test = () ->

  #
  @barChart = new Angle.BarChart
    el: '#bar-chart'
    data: []

  #
  @lineChart = new Angle.LineChart
    el: '#line-chart'
    data: []

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

test()
