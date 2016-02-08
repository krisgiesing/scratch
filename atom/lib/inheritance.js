var F = function() {};

Function.prototype.is = function(parent) {
    F.prototype = parent.prototype;
    this.prototype = new F();
}
