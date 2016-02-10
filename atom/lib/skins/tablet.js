require ('../inheritance');

var Skin = require('./skin');

var Tablet = function(resolution) {

}

Tablet.is(Skin);

Tablet.prototype.create = function(resolution) {
  var frame = {};
  frame.outer = $('<div></div>');
  frame.inner = $('<div></div>');
  frame.outer.append(frame.inner);
  return frame;
};

module.exports = Tablet;
