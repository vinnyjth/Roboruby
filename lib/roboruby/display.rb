module Roboruby
    class Display

        def initialize(match)
            @match = match
            @tiles ||= match.arena.map
        end

        def draw
            puts
            display_tiles = []
            display_tiles = @tiles.clone
            @match.bots.each do |b|
                display_tiles[b.position.y][b.position.x] = "@"
            end

            display_tiles.each do |row|
                puts row.join("")
            end

            if DEBUG
                puts @match.debug.each {|m| puts m }
            end
            
            puts @tiles
            puts
            puts "--------------------------"

            @match.debug = []
        end

    end
end
