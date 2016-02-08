require ('../inheritance.js');

var Primitive = require('./primitive.js');
var Inflater;

var Group = function(component, params) {
  Primitive.call(this, component, params);

  this.configureLayout(component, params);
  this.configureChildren(component, params.children);
};

Group.is(Primitive);

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
  this.element.css('display', 'flex');
  var direction = component.hoist(params['flex-direction']);
  if (direction === 'FlexDirection.horizontal')
    this.element.css('flex-direction', 'row')
  else if (direction === 'FlexDirection.vertical')
    this.element.css('flex-direction', 'column');
  else
    throw new Error("Invalid flex direction " + direction);

  var justify = component.hoist(params['flex-justify']);
  if (justify === "FlexJustify.spaceAround")
    this.element.css('justify-content', 'space-around');
  else if (justify === "FlexJustify.spaceBetween")
    this.element.css('justify-content', 'space-between');
  else if (justify === "FlexJustify.start")
    this.element.css('justify-content', 'start');
  else if (justify === "FlexJustify.end")
    this.element.css('justify-content', 'end');
  else if (justify === undefined)
    this.element.css('justify-content', 'space-between')
  else
    throw new Error("Invalid flex justify " + justify);
};

Group.prototype.configureChildren = function(component, children) {
  this.children = [];
  if (children !== undefined) {
    // Avoid issues due to circular dependency
    if (Inflater === undefined)
      Inflater = require('./inflater.js');
    var i;
    for (i = 0; i < children.length; i++) {
      this.children[i] = Inflater.inflate(component, children[i]);
      this.element.append(this.children[i].element);
    }
  }
};

module.exports = Group;
