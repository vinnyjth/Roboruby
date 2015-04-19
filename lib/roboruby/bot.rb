module Roboruby
    class Bot

        attr_accessor :x, :y
        attr_reader :energy
        
        def initialize(energy)
            @energy = energy
        end

        def position 
            {x: @x, y: @y}
        end

        def move(x_delta, y_delta)
            @x += x_delta
            @y += y_delta
            use_energy(x_delta + y_delta)
            position
        end

        private

        def use_energy(amount)
            energy -= amount
        end

    end
end
