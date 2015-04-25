module Roboruby
  class Position
    attr_reader :x, :y, :pos

    def initialize(arena, bot, initial_pos={})
      @arena = arena
      @bot = bot
      @match = bot.match
      if initial_pos.any?
        @pos = initial_pos
      else
        @pos = {x: 1, y:1}
      end
    end

    def move_relative!(x_delta, y_delta, stop_on_collision=true)
      x = @pos[:x] + x_delta
      y = @pos[:y] + y_delta
      points = RoboMath.points_in_line(@pos, {x:x, y:y})
      if stop_on_collision 
        points.each_with_index do |p, i|
          @old_pos = points[i-1] unless i == 0
          return move!(p) if space_invalid?
          return move!(p) if space_occupied?
        end
      end
      move!(points.last)
    end

    def move!(pos)
      @old_pos = @pos
      @pos = pos
      point
    end

    def revert!
      @pos = @old_pos
    end

    # Needs a more detailed implementation
    def push_other
      puts "Pushing other"
      v ||= velocity
      bots.each do |b|
        b.position.move_relative!(v[:x], v[:y])
      end
    end 

    def position=(pos={})
      @pos = pos
    end

    def space_valid?
      x = @pos[:x] 
      y = @pos[:y]
      @arena.space_valid?(x, y)
    end

    def space_invalid?
      !space_valid?
    end

    def space_occupied?
      bots.any?
    end

    def point
      @pos 
    end

    def velocity
      @pos.merge(@old_pos){ |k, old_val, new_val| old_val - new_val}
    end

    # TODO: This isn't true 
    def deadly?
      !space_valid?
    end

    def type
      @arena.space_type(@x, @y)
    end

    def bots
      (Position.get_bots_at(@pos, @match) || []).reject{ |b| b == @bot }
    end

    def x
      @pos[:x]
    end
    
    def y
      @pos[:y]
    end

    # TODO: This should really be an arena instance method.
    def self.get_bots_at(pos, match)
        match.bots.find_all {|b| b.position.point == pos } 
    end

  end
end
