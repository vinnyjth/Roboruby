require_relative "lib/roboruby"
a = Roboruby::Arena.new
m = Roboruby::Match.new a
b = Roboruby::Bot.new("basic", 10, m)
puts b.position.inspect
puts b.position.point
b.do_turn
puts b.position.point
