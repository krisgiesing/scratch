require ('../inheritance.js');

var Skin = require('./skin.js');

Watch = function(resolution) {

}

Watch.is(Skin);

Watch.prototype.create = function(resolution) {
  var frame = {};
  frame.outer = $('<div></div>');
  frame.outer.css({
    padding: '20px 20px 20px 20px',
    'background-color': 'black',
    'border-radius': '12px'
  });
  frame.inner = $('<div></div>');
  frame.inner.css({
    padding: '12px 12px 12px 12px',
    'background-color': 'white',
    'border-radius': '12px'
  });
  frame.outer.append(frame.inner);
  outer.append(inner);
  return frame;
};

module.exports = Watch;
