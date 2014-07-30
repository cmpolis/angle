Angle.style = new class _Style

  #
  # Generated from http://tools.medialab.sciences-po.fr/iwanthue/
  #  with params: H: 0-360, C: 0-3 L: 0.26-1.5 
  palette: [
    "#5B5874", "#82D148", "#CF513A",
    "#C059CC", "#517240", "#D0B44D",
    "#80BEC7", "#BA4A7E", "#8AD59B",
    "#CFA8A9", "#86573A","#7C7DCB" ]

  #
  color: (ndx) =>
    ndx = Math.floor(Math.random() * @palette.length) unless ndx?

    # normal -> brighter -> darker
    if ndx < @palette.length
      @palette[ndx]
    else if ndx < @palette.length * 2
      d3.rgb(@palette[ndx % palette.length]).brighter()
    else if ndx < @palette.length * 2
      d3.rgb(@palette[ndx % palette.length]).darker()

    # Outside palette bounds
    else
      @color(ndx % (@palette.length * 3))
