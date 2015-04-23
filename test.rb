require_relative "lib/roboruby"
a = Roboruby::Arena.new
m = Roboruby::Match.new a
b0 = Roboruby::Bot.new("basic", 40, m)
b1 = Roboruby::Bot.new("basic2", 40, m)
b1.position.position = {y: 1, x: 4} 
20.times do
    puts b0.memory
    Roboruby::Turn.new(m)
end

puts b0.memory
