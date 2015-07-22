require "erb"

module Roboruby
  class TurnDisplay
    #Will eventully become Roboruby::Display

    def self.render_erb(turns, output, template="turn")
      robo_turns = turns
      turns = robo_turns.map(&:arena_map)
      bots = robo_turns.map(&:bots)
      turns = turns.each_with_index.map do |turn, i|
        bots[i].each_with_index do |b|
          turn[b.position.y][b.position.x] = -1
        end
        turn
      end
      @turns = turns
      erb = ERB.new(File.open("#{__dir__}/templates/#{template}.html.erb").read, 0, '>')
      File.open("#{__dir__}/#{output}.html", 'w') { |f| f.write erb.result binding }
    end

    def self.tile_to_color(tile)
      case tile
      when 0
        "white"
      when 1
        "red"
      when -1
        "green"
      end
    end

  end
end
