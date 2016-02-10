var FS = require("fs")
var PEG = require("pegjs");
var ADIN = require("./parser");

var sample = 'group { hint: "horizontal", "dashed-property": 3.0, [ icon {}, image {} ]}'
console.log("ADIN = " + sample)

var result = ADIN.parse(sample);
var result_string = JSON.stringify(result);
console.log("JSON = " + result_string);
