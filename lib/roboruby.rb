$: << File.dirname(__FILE__)

VALIDSPACES = [1]
SPACES = {
    1 => :wall,
    0 => :empty
}
require 'roboruby/match'
require 'roboruby/arena'
require 'roboruby/position'
require 'roboruby/script'
require 'roboruby/turn'
require 'roboruby/bot'
require 'roboruby/bot_lua'
require 'roboruby/runner'

require 'roboruby/abilities/base'
