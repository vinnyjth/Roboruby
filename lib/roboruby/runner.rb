module Roboruby
    class Runner 

        attr_reader :lua, :bot, :mach

        def initialize 
            @match = Roboruby::Match.new(Roboruby::Arena.new)
            @bot = Roboruby::Bot.new("basic", 10) 
            @bot = @match.add_bot(@bot)
        end        

    end
end


