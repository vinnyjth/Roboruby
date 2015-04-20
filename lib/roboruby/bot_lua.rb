require 'rufus-lua'

module Roboruby

    class BotLua
    
        attr_accessor :bot, :lua

        def initialize(bot) 
            @lua = Rufus::Lua::State.new
            @bot = bot
            setup_functions
        end

        def match
            @match ||= bot.match
        end

        def run(code)
            @lua.eval code 
        end

        private 

        def setup_functions
            
            @lua.function "get_self_pos" do
                @bot.position
            end

            @lua.function "get_bot_pos" do |bot_name|
                @match.get_bot(bot_name).position
            end

            @lua.function "up" do |amount|
                @bot.move!(0, amount.to_i)
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
