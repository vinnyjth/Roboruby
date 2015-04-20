require'term/ansicolor'

class String
  include Term::ANSIColor
end

class Array
  def deep_dup
     Marshal.load(Marshal.dump(self))
  end
end
