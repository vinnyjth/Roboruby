module Roboruby
    class Runner 

        attr_reader :lua, :bot, :mach

        def initialize 
            @match = Roboruby::Match.new
            @bot = @match.add_bot Roboruby::Bot.new
            @lua = Roboruby::BotLua.new(@bot)
        end        

    end
end


