require 'rufus-lua'

module Roboruby

  class BotLua

    attr_accessor :bot, :lua

    def initialize(bot)
      @lua = Rufus::Lua::State.new
      @bot = bot
      @match = bot.match
      setup_functions
    end

    def run(code)
      @lua.eval(code)
    end

    private

    def setup_functions

      @lua.function "set_memory" do |memory|
        @bot.memory = memory.to_h
      end

      @lua.function "get_memory" do |memory|
        @bot.memory || {}
      end

      @lua.function "get_self_pos" do
        @bot.position.point
      end

      @lua.function "get_bot_pos" do |bot_name|
        @match.get_bot(bot_name).position.point
      end

      @lua.function "get_tile_at_pos" do |x, y|
        @match.arena.space_type({x:x, y:y}).to_s
      end

      @lua.function "get_bot_at_pos" do |x, y|

      end

      @lua.function "forward" do |amount|
        @bot.move_forward(1.0)
      end

      @lua.function "backward" do |amount|
        @bot.move_forward(-1.0)
      end

      @lua.function "left" do |amount|
        @bot.turn_left
      end

      @lua.function "right" do |amount|
        @bot.turn_right
      end

      @lua.function "get_energy" do
        @bot.check_energy
      end

      @lua.function "get_tile_in_front" do
        @bot.tile_in_front.to_s
      end

      @lua.function "get_turn_count" do
        @match.turn_count 
      end

      @bot.abilities.each do |key, ability|
        @lua.function ability.command do |*args|
          ability.perform(*args)
        end
      end

    end


  end

end
