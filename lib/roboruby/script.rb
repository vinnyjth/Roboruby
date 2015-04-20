module Roboruby
    class Script

        attr_reader :body

        def initialize(name)
            @body = load_script_body(name)
        end

        private

        def load_script_body(script_name)
            file = File.expand_path("../../../scripts/#{script_name}.lua", __FILE__)
            File.read(file)
        end 
    end
end
