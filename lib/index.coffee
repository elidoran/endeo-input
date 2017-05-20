{Buffer} = require 'buffer'

# a helper class which:
#  1. wraps a buffer
#  2. maintains an index into the buffer
#  3. grabs various bytes as numbers, buffer slice, or string.
class Input

  constructor: (buffer, index, options) ->

    # the input buffer
    @buffer  = buffer ? options?.buffer ? Buffer.alloc 0

    # the start index into `@buffer`
    @index = index ? options?.index ? 0


  hasByte: -> @index < @buffer.length


  hasBytes: (amount) -> @index + amount <= @buffer.length


  # return the next byte *without* incrementing
  peek: -> @buffer[@index]

  # consume the byte we didn't with peek()
  eat: -> @index++ ; return this

  # backup a single byte and return this so we can do something like:
  #   debyte.decode(input.back())
  back: -> @index-- ; return this


  # return the next byte and *increment* our index
  byte: -> if @index < @buffer.length then @buffer[@index++]


  # similar to byte() except a buffer slice is provided for multiple bytes.
  # if there aren't enough bytes then return an error
  bytes: (n) ->
    if @index + n <= @buffer.length then @buffer.slice @index, (@index += n)
    else error: 'insufficient bytes', wanted: n, available: @buffer.length - @index


  # get a two byte int and increment index
  short: ->
    i = @buffer.readUInt16BE @index, true
    @index += 2
    return i


  # get an int using specified number of bytes (1-6 is supported by Buffer)
  # and increment index.
  int: (bytes) ->
    i = @buffer.readUIntBE @index, bytes, true
    @index += bytes
    return i


  # get a 4 byte float and increment index
  float4: ->
    f = @buffer.readFloatBE @index, true
    @index += 4
    return f


  # get an 8 byte float and increment index
  float8: ->
    f = @buffer.readDoubleBE @index, true
    @index += 8
    return f


  # convert specified number of bytes into a string and increment index
  string: (bytes) -> @buffer.toString 'utf8', @index, (@index += bytes)




# export a builder function and the class
module.exports = (buffer, index, options) -> new Input buffer, index, options
module.exports.Input = Input
