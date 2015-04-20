module Roboruby
  class Display

    def initialize(match)
      @match = match
      @tiles = match.arena.map
    end

    def draw
      puts
      display_tiles = @tiles.deep_dup
      puts display_tiles.class
      puts @tiles.class
      puts @tiles[3][1]
      colors = %W[ red blue orange green]
      @match.bots.each_with_index do |b, i|
        display_tiles[b.position.y][b.position.x] = "@".send(colors[i])
      end

      display_tiles.each do |row|
        puts row.join("")
      end

      if DEBUG
        @match.debug.each {|m| puts m }
      end
      
      puts
      puts "--------------------------"

      @match.debug = []
    end

  end
end
