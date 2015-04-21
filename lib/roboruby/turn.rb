module Roboruby
  class Turn

    def initialize(match)
      @match = match
      @bots = match.bots
      run
    end


    def run
      @bots.each do |bot|
        bot.do_turn
      end
      @match.draw
    end

  end
end
