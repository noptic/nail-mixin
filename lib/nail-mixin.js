(function() {
  var _;

  _ = require('underscore');

  module.exports = {
    scope: 'mixin',
    augment: function(newClass) {
      var constructor, mixin, mixins, _i, _len, _ref;
      mixins = (_ref = newClass.definition[this.scope]) != null ? _ref : [];
      if (!_.isArray(mixins)) {
        mixins = [mixins];
      }
      constructor = newClass.prototype.constructor;
      for (_i = 0, _len = mixins.length; _i < _len; _i++) {
        mixin = mixins[_i];
        this.api.mixin(newClass.prototype, mixin);
      }
      newClass.prototype.constructor = constructor;
      return this;
    },
    api: {
      mixin: function(target, mixin) {
        _.extend(target, new mixin());
        return this;
      }
    }
  };

}).call(this);
