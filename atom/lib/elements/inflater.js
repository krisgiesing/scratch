var Inflater = {};
module.exports = Inflater;

// Note, defeat circular dependency by requiring after module.exports assignment
var elements = {};
elements.component = require('./component.js');
elements.group = require('./group.js');
elements.icon = require('./icon.js');
elements.image = require('./image.js');
elements.text = require('./text.js');

Inflater.inflate = function(component, params) {
  var type = params.type;
  delete params.type;
  if (elements[type] !== undefined) {
    var Constructor = elements[type];
    return new Constructor(component, params);
  }
  throw new Error("No way to inflate object of type " + type);
}
