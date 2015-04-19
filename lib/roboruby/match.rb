module Roboruby
    class Match 
       
        attr_accessor :bots
        attr_reader :arena

        def initialize(arena)
            @bots = []
            @arena = arena
        end

        def add_bot(bot)
            @bots << bot
            bot
        end

        def find_bot(name)
            @bots.find{|b| b.name == name}
        end

    end
end
