module Roboruby
    class Position
        attr_reader :x, :y
    
        def initialize(arena, bot, initial_pos=nil)
            @arena = arena
            @bot = bot
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

        def push_other
            
        end 

        def space_valid?
            @arena.space_valid?(@x, @y)
        end

        def point
            {x: @x, y: @y}
        end

        def deadly?
            !space_valid?
        end

        def type
            @arena.space_type(@x, @y)
        end

        def  self.get_bot_at(x, y)
            
        end
    end
end
