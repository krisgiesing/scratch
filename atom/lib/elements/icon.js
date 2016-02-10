require ('../inheritance');

var Element = require('./element');

var sIconBase = '\u2701'.charCodeAt(0);

var Icon = function(component, params) {
  Element.call(this, component, params);
  this.node.addClass('monocle-icon');
  if (params.content !== undefined) {
    this.node.css('background-image', component.hoist(params.content));
  } else {
    var offset = Math.floor(Math.random()*192);
    this.node.text(String.fromCharCode(sIconBase + offset));
  }
};

Icon.is(Element);

module.exports = Icon;
