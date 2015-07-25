module Roboruby
  class Position
    attr_reader :x, :y, :pos, :radian_orientation

    def initialize(arena, bot, initial_pos={})
      @arena = arena
      @bot = bot
      @match = bot.match
      if initial_pos.any?
        @pos = initial_pos
      else
        @pos = {x: 1, y:1}
      end
      @dir_vect = {x: 0, y: 0}
      @velocity = {x: 0, y:0}
      @radian_orientation = 0.0
    end

    def move_relative_with_collision(x_delta, y_delta)
      x = @pos[:x] + x_delta
      y = @pos[:y] + y_delta
      move_with_collision(x, y)
    end

    def move_with_collision(x, y)
      points = RoboMath.points_in_line(@pos, {x:x, y:y})
      return if points.length <= 1
      points.slice(1..-1).each_with_index do |p, i|
        @old_pos = i > 0 ? points[i-1] : @pos
        if space_invalid?(p)
          stop
          return move!(@old_pos)
        end
        if space_occupied?(p)
          stop
          move!(@old_pos)
        end
      end
      move!(points.last)
    end

    def calculate_velocity
      @velocity[:x] += @bot.acceleration_rate * Math.sin(@radian_orientation) * @arena.friction
      @velocity[:y] += @bot.acceleration_rate * Math.cos(@radian_orientation) * @arena.friction
      @velocity
    end

    def calculate_turn_left(delta_r=nil)
      delta_r = delta_r || @bot.rotation_speed
      @radian_orientation += delta_r
      if @radian_orientation > Math::PI*2
        @radian_orientation = 0
      elsif @radian_orientation < 0
        @radian_orientation = Math::PI*2
      end
      degree_orientation
    end

    def calculate_turn_right(delta_r=nil)
      delta_r = delta_r || @bot.rotation_speed
      @radian_orientation -= delta_r
      if @radian_orientation > Math::PI*2
        @radian_orientation = 0
      elsif @radian_orientation < 0
        @radian_orientation = Math::PI*2
      end
      degree_orientation
    end

    def update_position
      calculate_velocity
      desired_pos_x = @velocity[:x] + @pos[:x]
      desired_pos_y = @velocity[:y] + @pos[:y]
      puts "DESIRED POS #{desired_pos_x} x #{desired_pos_y}"
      move_with_collision(desired_pos_x.round, desired_pos_y.round)
    end

    def degree_orientation
      (@radian_orientation / Math::PI) * 180
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
      bots.each do |b|
        b.position.move_relative!(v[:x], v[:y])
      end
    end

    def position=(pos={})
      @pos = pos
    end

    def space_valid?(points = {})
      points = points || @pos
      @arena.space_valid?(points)
    end

    def space_invalid?(points = {})
      points = points || @pos
      if !space_valid?(points)
        true
      else
        false
      end
    end

    def space_in_front
      x = Math.sin(@radian_orientation) + @pos[:x]
      y = Math.cos(@radian_orientation) + @pos[:y]
      {x: x.round, y: y.round}
    end

    def space_occupied?(points = {})
      points = points || @pos
      Position.get_bots_at(points, @match || []).reject{ |b| b == @bot }.any?
    end

    def point
      @pos
    end

    # TODO: This isn't true
    def deadly?
      !space_valid?
    end

    def type
      @arena.space_type(@pos)
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

    def stop
      @velocity = {x: 0, y: 0}
    end

    # TODO: This should really be an arena instance method.
    def self.get_bots_at(pos, match)
        match.bots.find_all {|b| b.position.point == pos }
    end

  end
end
