require_relative "lib/roboruby"
a = Roboruby::Arena.new
m = Roboruby::Match.new a
b = Roboruby::Bot.new("basic", 10, m)
Roboruby::Turn.new(m)
Roboruby::Turn.new(m)
Roboruby::Turn.new(m)
Roboruby::Turn.new(m)
