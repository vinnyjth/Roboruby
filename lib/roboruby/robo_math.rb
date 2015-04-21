class RoboMath

  def self.points_in_line(start, finish)
    points = []
    # y = mx + b baby!
    dy = finish[:y] - start[:y] 
    dx = finish[:x] - start[:x]
    reversed = start[:x] > finish[:x]
    range = reversed ? (finish[:x]..start[:x]) : (start[:x]..finish[:x])
    range.each do |x|
      y = start[:y] + dy * (x - start[:x]) / 1
      points << {x: x, y: y}
    end
    puts points
    reversed ? points.reverse : points
  end

end
