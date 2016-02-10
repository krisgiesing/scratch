require ('../inheritance');

var Element = require('./element');
var Inflater = require('./inflater');

var Group = function(component, params) {
  Element.call(this, component, params);

  this.configureLayout(component, params);
  this.configureChildren(component, params.children);
};

Group.is(Element);

Group.prototype.configureLayout = function(component, params) {
  if (params.strategy !== undefined) {
    switch (params.strategy) {
      case 'flex':
        this.configureFlex(component, params);
        break;
      default:
        break;
    }
  }
};

Group.prototype.configureFlex = function(component, params) {
  this.node.css('display', 'flex');
  var direction = component.hoist(params['flex-direction']);
  if (direction === 'FlexDirection.horizontal')
    this.node.css('flex-direction', 'row')
  else if (direction === 'FlexDirection.vertical')
    this.node.css('flex-direction', 'column');
  else
    throw new Error("Invalid flex direction " + direction);

  var justify = component.hoist(params['flex-justify']);
  if (justify === "FlexJustify.spaceAround")
    this.node.css('justify-content', 'space-around');
  else if (justify === "FlexJustify.spaceBetween")
    this.node.css('justify-content', 'space-between');
  else if (justify === "FlexJustify.start")
    this.node.css('justify-content', 'start');
  else if (justify === "FlexJustify.end")
    this.node.css('justify-content', 'end');
  else if (justify === undefined)
    this.node.css('justify-content', 'space-between')
  else
    throw new Error("Invalid flex justify " + justify);
};

Group.prototype.configureChildren = function(component, children) {
  this.children = [];
  if (children !== undefined) {
    var i;
    for (i = 0; i < children.length; i++) {
      this.children[i] = Inflater.inflate(component, children[i]);
      this.node.append(this.children[i].node);
    }
  }
};

module.exports = Group;
