require ('../inheritance.js');

var Primitive = require('./primitive.js');

var sIconBase = '\u2701'.charCodeAt(0);

var Icon = function(component, params) {
  Primitive.call(this, component, params);
  this.element.addClass('monocle-icon');
  if (params.content !== undefined) {
    this.element.css('background-image', component.hoist(params.content));
  } else {
    var offset = Math.floor(Math.random()*192);
    this.element.text(String.fromCharCode(sIconBase + offset));
  }
};

Icon.is(Primitive);

module.exports = Icon;
