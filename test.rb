require_relative "lib/roboruby"
a = Roboruby::Arena.new
m = Roboruby::Match.new a
b = Roboruby::Bot.new("basic", 40, m)
20.times do 
    Roboruby::Turn.new(m)
end
