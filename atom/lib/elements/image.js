require ('../inheritance');

var Element = require('./element');

var Image = function(component, params) {
  Element.call(this, component, params);
  if (params.content !== undefined)
    this.node.css('background-image', component.hoist(params.source));
  else
    this.node.addClass('placeholder-image');
};

Image.is(Element);

module.exports = Image;
