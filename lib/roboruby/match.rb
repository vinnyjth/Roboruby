module Roboruby
    class Match 
       
        attr_accessor :bots
        attr_reader :arena

        def initialize(arena)
            @bots = []
            @arena = arena
        end
        
        def start
            play                    
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
