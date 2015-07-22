require_relative "lib/roboruby"
a = Roboruby::Arena.new
m = Roboruby::Match.new a
b0 = Roboruby::Bot.new("basic", 40, m)
b1 = Roboruby::Bot.new("basic2", 40, m)
b1.position.position = {y: 1, x: 4}
@turns = []
20.times do
    @turns << Roboruby::Turn.new(m)
end
Roboruby::TurnDisplay.render_erb(@turns, "bakbal")
