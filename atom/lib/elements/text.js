require ('../inheritance');

var Element = require('./element');

var Text = function(component, params) {
  Element.call(this, component, params);
  if (params.content !== undefined)
    this.node.text(component.hoist(params.content));
  else if (params.size === 'small')
    this.node.text('Sin');
  else if (params.size === 'medium')
    this.node.text('Lorem ipsum');
  else if (params.size === 'large')
    this.node.text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum');
};

Text.is(Element);

module.exports = Text;
