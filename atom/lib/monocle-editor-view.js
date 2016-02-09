var $ = require('jquery');
var fs = require('fs');
var path = require('path');

var Skins = require('./skins/skins.js');
var Phone = require('./skins/phone.js');
var Inflater = require('./elements/inflater.js');

var sData = null;
var sDataDir = path.dirname(module.filename);

// Input is the MonocleTab in which this editor view opened
var ModuleEditorView = function(tab) {
  var canvas = $('<div></div>');
  canvas.addClass('main-view');
  var scroller = $('<div></div>');
  scroller.addClass('scroller');
  canvas.append(scroller);
  // Default to iPhone 4 dimensions
  var skin = Skins.choose('phone', {
    width: 640,
    height: 960
  });
  var component = { // eventually a top level object...
    dir: tab.dir
  };
  var element = Inflater.inflate(component, tab.model);
  skin.frame.inner.append(element.node);
  //skin.frame.outer.css('transform', 'scale(0.5)');
  scroller.append(skin.frame.outer);
  return canvas;
};

module.exports = ModuleEditorView;
