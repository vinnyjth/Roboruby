module Roboruby
    class Display

        def self.draw(match)
            puts
            tiles = match.arena.map
            match.bots.each do |b|
                tiles[b.position.y][b.position.x] = "x"
            end

            tiles.each do |row|
                puts row.join("")
            end

            if DEBUG
                puts match.debug.each {|m| puts m }
            end

            puts
            puts "--------------------------"
        end

    end
end
