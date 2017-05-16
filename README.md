# @endeo/input
[![Build Status](https://travis-ci.org/elidoran/endeo-input.svg?branch=master)](https://travis-ci.org/elidoran/endeo-input)
[![Dependency Status](https://gemnasium.com/elidoran/endeo-input.png)](https://gemnasium.com/elidoran/endeo-input)
[![npm version](https://badge.fury.io/js/%40endeo%2Finput.svg)](http://badge.fury.io/js/%40endeo%2Finput)
[![Coverage Status](https://coveralls.io/repos/github/elidoran/endeo-input/badge.svg?branch=master)](https://coveralls.io/github/elidoran/endeo-input?branch=master)

Helps extract values from a buffer during decoding.

See packages:

1. [endeo](https://www.npmjs.com/package/endeo)
3. [debyte](https://www.npmjs.com/package/debyte)


## Install

```sh
npm install --save @endeo/input
```


## Usage


```javascript
// get the builder
var Input = require('@endeo/input')

// build one with buffer/index
var input = new Input({
  buffer: someBuffer,
  index : 0
})

// look at the next byte without advancing index:
var byte = input.peek()

// advance index one passed the one we peeked at:
input.eat()

// get the next byte and advance index:
byte = input.byte()

// backup an index and return itself:
// useful if you want to backup one and pass input on...
input.back()

// check if we have another byte available
input.hasByte()

// check if we have a set number of bytes available:
input.hasBytes(5)

// get a two byte int value:
input.short()

// get an int from next 1 to 6 bytes:
input.int(4) // accepts 1-6

// get 4 byte floating point number:
input.float4()

// get 8 byte floating point number:
input.float8()

// get a string using the specified byte count:
input.string(12)

// get a buffer slice the size specified:
input.bytes(8)
```


# [MIT License](LICENSE)
