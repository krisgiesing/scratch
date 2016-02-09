var $ = require('jquery');

require ('../inheritance.js');

// Subclasses should create an element member representing the DOM
// element to be tied into the tree.
var Element = function(component, params) {
  this.node = this.create(component, params);
  if (params.opacity !== undefined)
    this.node.css('opacity', component.hoist(params.opacity));
  if (params.background !== undefined)
    this.node.css('background-color', component.hoist(params.background));
  // Margin, padding, background images, etc.
}

Element.prototype.create = function() {
  return $('<div></div>');
}

module.exports = Element;
