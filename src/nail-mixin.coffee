# nail-mixin
# https://github.com/Oliver/nail-mixin
#
# Copyright (c) 2013 Oliver Anan
# Licensed under the MIT license.
_ = require 'underscore'
module.exports =
  scope:  'mixin'
  augment: (newClass) ->
    mixins = newClass.definition[@scope] ? []
    if ! _.isArray mixins
      mixins = [mixins]
    constructor = newClass::constructor
    for mixin in mixins
      @api.mixin newClass.prototype, mixin
    newClass::constructor = constructor
    return this

  api:
    mixin: (target, mixin) ->
      _.extend target, new mixin()
      return this