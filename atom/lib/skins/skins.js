require ('../inheritance.js');

var skins = {};
skins.watch = require('./watch.js');
skins.phone = require('./phone.js');
skins.tablet = require('./tablet.js');
skins.tv = require('./tv.js');

var Skins = {};

Skins.choose = function(name, resolution) {
  var Constructor = skins[name];
  return new Constructor(resolution);
};

module.exports = Skins;
