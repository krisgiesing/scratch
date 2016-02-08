require ('../inheritance.js');

var Primitive = require('./primitive.js');

var Text = function(component, params) {
  Primitive.call(this, component, params);
  if (params.content !== undefined)
    this.element.text(component.hoist(params.content));
  else if (params.size === 'small')
    this.element.text('Sin');
  else if (params.size === 'medium')
    this.element.text('Lorem ipsum');
  else if (params.size === 'large')
    this.element.text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum');
};

Text.is(Primitive);

module.exports = Text;
