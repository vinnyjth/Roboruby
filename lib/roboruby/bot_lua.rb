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
            @lua.eval code
        end

        private 

        def setup_functions
            
            @lua.function "get_self_pos" do
                @bot.position.point
            end

            @lua.function "get_bot_pos" do |bot_name|
                @match.get_bot(bot_name).position.point
            end

            @lua.function "get_tile_at_pos" do |x, y|
                @match.arena.space_type(x, y).to_s
            end

            @lua.function "up" do |amount|
                @bot.move!(0, (amount.to_i)*-1)
            end

            @lua.function "down" do |amount|
                @bot.move!(0, amount.to_i)
            end

            @lua.function "left" do |amount|
                @bot.move!((amount * -1).to_i, 0)
            end

            @lua.function "right" do |amount|
                @bot.move!(amount.to_i, 0)
            end

            @lua.function "get_energy" do
                @bot.check_energy
            end

            @bot.abilities.each do |key, ability|
                @lua.function ability.command do |*args|
                    ability.perform(*args)
                end
            end

        end


    end

end
