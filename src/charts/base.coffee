#
#
# Abstract class to be extended by chart types

class Angle.ChartBase
  
  # Defaults
  padding:
    top:    40
    right:  40
    bottom: 40
    left:   40
  height: 600
  width:  600

  ###
  ###

  constructor: (options = {}) ->

    #
    unless options.el and (@el = d3.select(options.el)[0])
      throw "DOM Element not found, pass in a valid selector as `el`"

    #
    @svg = @el.append 'svg'

    #
    _.extend @padding, Angle.settings.padding if Angle.settings.padding?
    _.extend @padding, options if options.padding?

    #
    if options.height
      @height = options.height
    else if (elHeight = parseInt(d3.select('#ohlc').style('height'))) > 0
      @height = elHeight
    else if Angle.settings.height
      @height = Angle.settings.height

    #
    if options.width
      @width = options.height
    else if (elWidth = parseInt(d3.select('#ohlc').style('width'))) > 0
      @width = elWidth
    else if Angle.settings.width
      @width = Angle.settings.height

    #
    @initialize(options) if @initialize?

  ###
  ###

  render: () =>
    throw "render() not implemented"
