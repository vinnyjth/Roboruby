module Roboruby
  class Bot

    attr_accessor :x, :y, :name, :memory, :acceleration_rate, :rotation_speed
    attr_reader :energy, :lua, :abilities, :position, :match, :alive

    def initialize(name, energy, match, opts = {})
      defaults = {speed: 0.0, rotation_speed: Math::PI/2}
      opts = defaults.merge(opts)
      @match = match
      @arena = match.arena
      @position = Roboruby::Position.new(match.arena, self)
      @energy = energy
      @regain_amount = 0
      @abilities = {}
      @lua = Roboruby::BotLua.new(self)
      @script = Roboruby::Script.new(name)
      @alive = true
      @name = name
      @memory = {}
      @acceleration_rate = opts[:speed]
      @rotation_speed = opts[:rotation_speed]
      @match.add_bot(self)
    end

    def move_forward(speed)
      @acceleration_rate = speed
    end

    def brake
      @position.stop
    end

    def turn_left
      @position.calculate_turn_left((1.0/2.0)*Math::PI)
    end

    def turn_right
      @position.calculate_turn_left((1.0/2.0)*Math::PI)
    end

    def tile_in_front
      @arena.space_type(@position.space_in_front)
    end

    def do_turn
      puts @lua.run @script.body
      puts name
      update_position
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

    def update_position
      @position.update_position
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

    def halt
      @position.halt
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
      halt!
    end

  end
end
