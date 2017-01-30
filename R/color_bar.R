# Source: http://www.colbyimaging.com/wiki/statistics/color-bars
color.bar <- function(lut, min, max=-min, nticks=11, ticks=seq(min, max, len=nticks), title='', horiz=FALSE) {
  scale = (length(lut))/(max-min)
  # dev.new(width=1.75, height=5)
  if (horiz==FALSE) {
    plot(c(0,1), c(min,max), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='', main=title)
    axis(2, round(ticks, 2), las=1)
    for (i in 1:(length(lut))) {
      y = (i-1)/scale + min
      rect(0,y,10,y+1/scale, col=lut[i], border=NA)
    }
  } else {
    plot(c(min,max), c(0,1), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='', main=title)
    axis(1, round(ticks, 2), las=1)
    for (i in 1:(length(lut))) {
      x = (i-1)/scale + min
      rect(x,0,x+1/scale,10, col=lut[i], border=NA)
    }
  }
}
