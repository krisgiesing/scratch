require ('../inheritance.js');

var Primitive = require('./primitive.js');

var Image = function(component, params) {
  Primitive.call(this, component, params);
  if (params.content !== undefined)
    this.element.css('background-image', component.hoist(params.source));
  else
    this.element.addClass('placeholder-image');
};

Image.is(Primitive);

module.exports = Image;
