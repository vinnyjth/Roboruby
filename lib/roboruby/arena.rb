require 'json'
module Roboruby 
    class Arena

        attr_reader :map, :name

        def initialize(layout=nil)
            layout_name = layout || "basic"
            @map, @name = load_layout(layout_name) 
        end
        
        def space_valid?(x, y)
            return false if space_nil?(x, y)
            space_at(x, y).in VALIDSPACES 
        end

        def space_nil?(x, y)
            y > @map.length || x > @map[y]
        end

        def space_at(x, y)
            @map[y][x]
        end

        def space_type(x, y)
            return :empty if space_nil?(x, y)
            SPACES[space_at(x, y)] || :empty
        end

        private

        def load_layout(layout_name)
            file = File.expand_path("../../../layouts/#{layout_name}.json", __FILE__)
            layout_json = File.read(file)
            data = JSON.parse(layout_json)
            return data['layout'], data['name']
        end

    end
end
