module Roboruby
    class Match 
       
        attr_accessor :debug
        attr_reader :arena, :bots

        def initialize(arena)
            @bots = []
            @debug = []
            @arena = arena
            @display = Roboruby::Display.new(self)
        end
        
        def start
            play                    
        end

        def draw
            @display.draw
        end
    
        def add_bot(bot)
            @bots << bot
            bot
        end

        def find_bot(name)
            @bots.find{|b| b.name == name}
        end

        def remove_bot(name)
            @bots.delete find_bot(name)
        end

        private 

        def play
            active = true

            while active
                turn = Roboruby::Turn.new(self)
                turn = nil 
                winner = check_for_winner
                active = true unless winner.present?
            end
        end

        def check_for_winner
            if @bots.size == 1
                @bots.first
            else
                nil
            end
        end

    end
end
