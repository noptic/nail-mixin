nail_mixin = require '../lib/nail-mixin.js'
_ = require 'underscore'
nail = require('nail-core').use(
  nail_mixin
  require 'nail-methods'
)

module.exports =
  "structure":
    "api methods exists": (test) ->
      test.expect 1
      test.ok (_.isFunction nail_mixin.api.mixin)
      test.done()

  "augment":
    setUp: (done)->
      @classes = {}
      nail
      .to @classes, 'test'
        MyMixin:
          methods:
            hello:  -> 'hello mixin'
            bye:    -> 'bye mixin'
        MyOtherMixin:
          methods:
            identity: (value) -> value
      .to @classes, 'test',
        MyClass:
          mixin: @classes.MyMixin
          methods:
            bye: -> 'bye class'
        MyOtherClass:
          mixin: [@classes.MyMixin, @classes.MyOtherMixin]

      @instance = new @classes.MyClass()
      @otherInstance = new @classes.MyOtherClass()
      done()

    "mixin methods are added":(test) ->
      test.expect 3
      test.equals @instance.hello(), 'hello mixin'
      test.equals @otherInstance.bye(), 'bye mixin'
      test.equals @otherInstance.identity(12), 12
      test.done()

    "explicit method oerrides mixxin":  (test) ->
      test.expect 1
      test.equals @instance.bye(), 'bye class'
      test.done()
