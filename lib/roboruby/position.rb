module Roboruby
  class Position
    attr_reader :x, :y

    def initialize(arena, bot, initial_pos=nil)
      @arena = arena
      @bot = bot
      @match = bot.match
      if initial_pos
        @x = initial_pos[:x]
        @y = initial_pos[:y]
      else 
        @x = 1
        @y = 1
      end
      @old_x = @x
      @old_y = @y
    end

    def move_relative!(x_delta, y_delta)
      x = @x + x_delta
      y = @y + y_delta
      move!(x, y)
    end

    def move!(x, y)
      @old_x = @x
      @old_y = @y
      @x = x
      @y = y
    end

    def revert!
      @x = @old_x
      @y = @old_y
    end

    # Needs a more detailed implementation
    def push_other
      v ||= velocity
      bots.each do |b|
        b.position.move_relative!(v[:x], v[:y])
      end
    end 

    def position=(pos={})
      @x = pos[:x]
      @y = pos[:y]
    end

    def space_valid?
      @arena.space_valid?(@x, @y)
    end

    def space_occupied?
      bots.any?
    end

    def point
      {x: @x, y: @y}
    end

    def velocity
      x_vel = @x - @old_x
      y_vel = @y - @old_y
      {x: x_vel, y: y_vel}
    end


    # TODO: This isn't true 
    def deadly?
      !space_valid?
    end

    def type
      @arena.space_type(@x, @y)
    end

    def bots
      (Position.get_bots_at(@x, @y, @match) || []).reject{ |b| b == @bot }
    end

    # TODO: This should really be an arena instance method.
    def self.get_bots_at(x, y, match)
        match.bots.find_all {|b| b.position.point == {x: x, y: y} } 
    end

  end
end
