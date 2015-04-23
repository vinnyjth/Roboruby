module Roboruby
  class Display

    def initialize(match)
      @match = match
      @tiles = match.arena.map
    end

    def draw
      puts
      display_tiles = @tiles.deep_dup
      colors = %W[ red blue orange green]
      display_tiles = display_tiles.map { |r| r.map { |c| c == 0 ? " " : "="} } 
      @match.bots.each_with_index do |b, i|
        display_tiles[b.position.y][b.position.x] = "@".send(colors[i])
      end

      display_tiles.each do |row|
        puts row.join("")
      end

      if DEBUG
        @match.debug.each {|m| puts m }
      end
      puts @match.debug
      
      puts
      puts "--------------------------"
    end

  end
end
