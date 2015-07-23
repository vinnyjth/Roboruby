require_relative "lib/roboruby"
a = Roboruby::Arena.new
m = Roboruby::Match.new a
b0 = Roboruby::Bot.new("basic", 40, m)
b1 = Roboruby::Bot.new("basic2", 40, m)
b1.position.position = {y: 1, x: 4}
turns_data = []
20.times do
    turn = Roboruby::Turn.new(m)
    arena_map = turn.arena_map.deep_dup
    bots = turn.bots
    bots.each_with_index do |b|
      arena_map[b.position.y][b.position.x] = -1
    end
    turns_data << arena_map
end
Roboruby::TurnDisplay.render_erb(turns_data, "bakbal")
