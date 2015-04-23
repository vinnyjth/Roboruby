module Roboruby
  class Bot

    attr_accessor :x, :y, :name, :memory
    attr_reader :energy, :lua, :abilities, :position, :match, :alive

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
      @memory = {}
      @match.add_bot(self)
    end

    def move!(x_delta, y_delta)
      return @position.point if energy_depleted?
      @position.move_relative!(x_delta, y_delta, true)
      use_energy(x_delta + y_delta)
      handle_tile_collision if @position.space_invalid?
      handle_bot_collision  if @position.space_occupied?
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
      @position.push_other
    end

    def combust!
      @alive = false
      @energy = 0
    end

    def bounce!
      @position.revert!
    end

    private

    def use_energy(amount)
      @energy -= amount
    end

    def regain_energy
      @energy += @regain_amount
    end

    def handle_tile_collision
      puts "fing tiles"
      case position.type
      when :deadly
        combust!
      when :wall
        bounce!
      end
    end

    def handle_bot_collision
      puts "Fing bots"
      push_other
    end

  end
end
