require 'json'
module Roboruby 
    class Arena

        attr_reader :map, :name

        def initialize(layout=nil)
            layout_name = layout || "basic"
            @map, @name = load_layout(layout_name) 
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
