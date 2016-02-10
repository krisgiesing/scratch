var $ = require('jquery');
require ('../inheritance');

var Skin = require('./skin');

var Phone = function(resolution) {
  Skin.call(this, resolution);
}

Phone.is(Skin);

Phone.prototype.create = function(resolution) {
  var frame = {};
  frame.outer = $('<div></div>');
  frame.outer.addClass('phone skin outer');
  frame.inner = $('<div></div>');
  frame.inner.addClass('phone skin inner');
  frame.outer.append(frame.inner);
  return frame;
};

module.exports = Phone;
