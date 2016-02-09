require ('../inheritance.js');

var Element = require('./element.js');

var Image = function(component, params) {
  Element.call(this, component, params);
  if (params.content !== undefined)
    this.node.css('background-image', component.hoist(params.source));
  else
    this.node.addClass('placeholder-image');
};

Image.is(Element);

module.exports = Image;
