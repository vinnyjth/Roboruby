module Roboruby
    class Runner 

        attr_reader :lua, :bot, :match

        def initialize 
            @match = Roboruby::Match.new(Roboruby::Arena.new)
            @bot = Roboruby::Bot.new("basic", 10) 
        end        

    end
end


