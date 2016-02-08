// frame is {outer: element, inner: element}
var Skin = function(resolution) {
  this.frame = this.create(resolution);
  this.frame.inner.css(resolution);
};

module.exports = Skin;
