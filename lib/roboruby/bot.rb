module Roboruby
    class Bot

        attr_accessor :x, :y, :name
        attr_reader :energy, :lua, :abilities, :position, :match
        
        def initialize(name, energy, match)            
            @match = match
            @position = Roboruby::Position.new(match.arena, self)
            @energy = energy
            @regain_amount = 0
            @abilities = {}
            @lua = Roboruby::BotLua.new(self)
            @script = Roboruby::Script.new(name)
            @alive = true
            @name = name
            @match.add_bot(self)
        end

        def move!(x_delta, y_delta)
            return @position.point if energy_depleted?
            @position.move_relative!(x_delta, y_delta)
            use_energy(x_delta + y_delta)
            handle_collision unless @position.space_valid?             
            @position.point
        end

        def do_turn
            @lua.run @script.body
            regain_energy
        end
        
        def energy_depleted?
            @energy <= 0
        end
        
        def add_abilities!(*new_abilities)
            new_abilities.each do |ability|
              klass = Object.const_get("Roboruby::Abilities::#{ability}").new(self)
              @abilities[klass.name] = klass 
            end
        end

        def push_other
            @poisition.push_other
        end

        def combust!
            @alive = false
            @energy = 0
            @match.remove_bot(@name)
        end

        def bounce
            @position.revert!
        end

        private

        def use_energy(amount)
            @energy -= amount
        end

        def regain_energy
            @energy += @regain_amount
        end

        def handle_collision
            case position.type
            when :deadly
                combust!
            when :taken
                push_other
            when :wall
                bounce
            else
                bounce
            end
        end

    end
end
