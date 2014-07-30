#
#
# Abstract class to be extended by chart types

Angle.ChartBase = class Angle.ChartBase
  
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
    unless options.el and (@el = d3.select(options.el))
      throw "DOM Element not found, pass in a valid selector as `el`"

    #
    _.extend @padding, Angle.settings.padding if Angle.settings.padding?
    _.extend @padding, options if options.padding?

    #
    if options.height
      @height = options.height
    else if (elHeight = parseInt(@el.style('height'))) > 0
      @height = elHeight
    else if Angle.settings.height?
      @height = Angle.settings.height

    #
    if options.width
      @width = options.width
    else if (elWidth = parseInt(@el.style('width'))) > 0
      @width = elWidth
    else if Angle.settings.width?
      @width = Angle.settings.width

    #
    @svg = @el.append 'svg'
      .style height: @height, width: @width
      .append 'g'
        .attr 'transform', "translate(#{@padding.left},#{@padding.top})"

    #
    @width = @width - @padding.right - @padding.left
    @height = @height - @padding.top - @padding.bottom

    #
    @initialize(options) if @initialize?
    @fetchOrRender options.data

  ###
  ###

  fetchOrRender: (data) =>
    
    # Array or hash passed in
    if typeof data is 'object'
      @data = data
      @afterFetch() if @afterFetch?
      @render()

    # URL passed in
    else if typeof data is 'string'
      @fetch data, () ->
        @render()

  ###
  ###

  fetch: (url, next) =>
    @dataUrl = data
    extension = @dataUrl.match(/\.[0-9a-z]+$/i)[0].toLowerCase()
    unless _.contains "text json xml csv tsv".split(' '), extension
      throw "Data url has invalid extension: #{extension}"

    # Call d3.json, d3.csv, d3.tsv, etc...
    d3[extension] @dataUrl, (error, data) =>
      throw error if error?
      @data = data
      @afterFetch() if @afterFetch?
      @next() if @next?
  
  ###
  ###

  xAxis: (options = {}) =>
    options = _.extend options,
      orientation: 'bottom'
      scale: @xScale
      ticks: 10
    d3.svg.axis()
      .scale  options.scale
      .ticks  options.ticks
      .orient options.orientation

  yAxis: (options = {}) =>
    options = _.extend options,
      orientation: 'left'
      scale: @yScale
      ticks: 10
    d3.svg.axis()
      .scale  options.scale
      .ticks  options.ticks
      .orient options.orientation

  ###
  ###

  render: () =>
    throw "render() not implemented"
