require ('../inheritance');

var skins = {};
skins.watch = require('./watch');
skins.phone = require('./phone');
skins.tablet = require('./tablet');
skins.tv = require('./tv');

var Skins = {};

Skins.choose = function(name, resolution) {
  var Constructor = skins[name];
  return new Constructor(resolution);
};

module.exports = Skins;
