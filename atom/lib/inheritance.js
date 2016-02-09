var Extension = function() {};

Function.prototype.is = function(parent) {
    Extension.prototype = parent.prototype;
    this.prototype = new Extension();
}
