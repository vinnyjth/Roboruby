$: << File.dirname(__FILE__)

VALIDSPACES = [0]
SPACES = {
    1 => :wall,
    0 => :empty
}
DEBUG = true
require 'roboruby/core_additions'
require 'roboruby/match'
require 'roboruby/arena'
require 'roboruby/position'
require 'roboruby/script'
require 'roboruby/turn'
require 'roboruby/bot'
require 'roboruby/bot_lua'
require 'roboruby/runner'
require 'roboruby/display'

require 'roboruby/abilities/base'
