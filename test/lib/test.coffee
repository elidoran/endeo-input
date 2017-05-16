assert = require 'assert'

build = require '../../lib/index.coffee'

describe 'test Input', ->

  it 'should build', -> assert build()
