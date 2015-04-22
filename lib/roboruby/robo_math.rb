class RoboMath

  # Uses Bresenham's algorithm
  # modified from http://www.roguebasin.com/index.php?title=Bresenham%27s_Line_Algorithm
  def self.points_in_line(start, finish)
    x0, x1 = start[:x], finish[:x]
    y0, y1 = start[:y], finish[:y]
    points = []
    steep = ((y1-y0).abs) > ((x1-x0).abs)
    if steep
      puts "You dun goofed"
      x0,y0 = y0,x0
      x1,y1 = y1,x1
    end
    flip = x0 > x1  
    if flip
      puts "Flippen"
      x0,x1 = x1,x0
      y0,y1 = y1,y0
    end
    deltax = x1-x0
    deltay = (y1-y0).abs
    error = (deltax / 2).to_i
    y = y0
    ystep = y0 < y1 ? 1 : -1
    for x in x0..x1
      if steep
        points << {:x => y, :y => x}
      else
        points << {:x => x, :y => y}
      end
      error -= deltay
      if error < 0
        y += ystep
        error += deltax
      end
    end
    flip ? points.reverse : points
  end

end
