require 'json'
module Roboruby
  class Arena

    attr_reader :map, :name, :friction

    def initialize(layout=nil)
      layout_name = layout || "basic"
      @map = load_layout(layout_name)
      @friction = 0.70
    end

    def space_valid?(position)
      return false if space_nil?(position)
      VALIDSPACES.include? space_at(position)
    end

    def space_nil?(position)
      position[:y] > @map.length || @map[position[:y]].nil? || position[:y] < 0
    end

    def space_at(position)
      unless space_nil?(position)
        @map[position[:y]][position[:x]]
      else
        nil
      end
    end

    def space_type(position)
      SPACES[space_at(position)] || :void
    end

    private

    def load_layout(layout_name)
      file = File.expand_path("../../../layouts/#{layout_name}.json", __FILE__)
      layout_json = File.read(file)
      data = JSON.parse(layout_json)
      data['layout']
    end

  end
end
