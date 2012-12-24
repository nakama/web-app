# Logger mixin

#### Examples
#    log 'This is a message',
#        info: data
#        otherthing: 'awesome'
#
#    log data1, data2, data3
#
#    warn 'Warning, this rocks', data1, warning_message: 'blah'
#
#    error 'No way.'
#

indent = 15
startTime = new Date().getTime()
showLogger = no

getOffset = (label='') ->
  length = indent - label.length + 1
  length = 0 if length < 0
  (new Array(length)).join(' ')

module.exports =

  error: (msg, data...) -> log msg, 'error', data...

  log: (msg, level='log', data...) ->
    return unless showLogger
    if level isnt 'log' and level isnt 'warn' and level isnt 'error'
      data.unshift level
      level = 'log'

    unless typeof msg is 'string'
      data.unshift msg
      msg = ''

    time = new Date().getTime()
    timeDiff = (time - startTime) + 'ms'

    console[level] getOffset( timeDiff ), timeDiff + ' ■', msg

    _(data).each (debug) ->
      if typeof debug is 'object'
        _(debug).each (value, key) ->
          console[level] getOffset( key ), key, value

  set: (state=no) -> showLogger = yes if state is on

  warn: (msg, data...) -> log msg, 'warn', data...
