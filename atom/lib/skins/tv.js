require ('../inheritance');

var Skin = require('./skin');

var TV = function(resolution) {

}

TV.is(Skin);

TV.prototype.create = function(resolution) {
  var frame = {};
  frame.outer = $('<div></div>');
  frame.inner = $('<div></div>');
  frame.outer.append(frame.inner);
  return frame;
};

module.exports = TV;
