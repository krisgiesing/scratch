require ('../inheritance.js');

$ = require('jquery');

var Element = require('./element.js');

var Primitive = function(component, params) {
  this.element = this.create();
  if (params.opacity !== undefined)
    this.element.css('opacity', component.hoist(params.opacity));
  if (params.background !== undefined)
    this.element.css('background-color', component.hoist(params.background));
  // Margin, padding, background images, etc.
}

Primitive.is(Element);

Primitive.prototype.create = function() {
  return $('<div></div>');
}

module.exports = Primitive;
