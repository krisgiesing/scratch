var fs = require('fs');
var path = require('path');

require ('../inheritance');

var Element = require('./element');
var Inflater = require('./inflater');
var Parser = require('../dsl/parser');

var Component = function(component, params) {
  Element.call(this, component, params);
};

Component.is(Element);

Component.prototype.create = function(component, params) {
  if (params.content !== undefined) {
    var fullpath = path.join(component.dir, params.content);
    if (path.extname(fullpath) == '')
      fullpath += '.cmpt';
    this.name = path.basename(fullpath, '.cmpt');
    this.dir = path.dirname(fullpath);

    var model = Parser.parse(fs.readFileSync(fullpath, 'utf8'));
    var element = Inflater.inflate(this, model);
    this.child = element;
    return element.node;
  } else {
    return Element.prototype.create.call(this, component, params);
  }
};

Component.prototype.hoist = function(property) {
  if (typeof property === 'string') {
    var match = property.match(/^\${(.*)}$/);
    if (match.length == 2)
      return this[match[1]];
  }
  return property;
}

module.exports = Component;
