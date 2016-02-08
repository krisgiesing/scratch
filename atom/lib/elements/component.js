require ('../inheritance.js');

var Element = require('./element.js');

var Component = function(component, params) {
  Element.call(this, component, params);
};

Component.hoist = function(property) {
  if (typeof property === 'string') {
    var match = property.match(/^\${(.*)}$/);
    if (match.length == 2)
      return this[match[1]];
  }
  return property;
}

Component.is(Element);

module.exports = Component;
