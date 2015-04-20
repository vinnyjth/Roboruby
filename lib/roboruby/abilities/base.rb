module Roboruby
    module Abilities
        class Base
            
            attr_reader :command, :klass, :name

            def initialize(bot)
                # The function name to be called from lua
                @command = "ping"
                # The class. Most likely a better way to do this
                @klass = "base"
                # The human readable name of the ability
                @name = :ping
            end

            def perform
                # Overridden by subclasses.
            end

        end
    end
end
