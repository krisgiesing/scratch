var Inflater = {};
module.exports = Inflater;

// Note, defeat circular dependency by requiring after module.exports assignment
var elements = {};
elements.component = require('./component');
elements.group = require('./group');
elements.icon = require('./icon');
elements.image = require('./image');
elements.text = require('./text');

Inflater.inflate = function(component, params) {
  var type = params.type;
  delete params.type;
  if (elements[type] !== undefined) {
    var Constructor = elements[type];
    return new Constructor(component, params);
  }
  throw new Error("No way to inflate object of type " + type);
}
