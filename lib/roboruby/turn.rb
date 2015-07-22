module Roboruby
  class Turn

    attr_accessor :arena_map, :bots

    def initialize(match)
      @match = match
      @bots = match.bots.dup
      @arena_map = match.arena.map.dup
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
