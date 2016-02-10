path = require 'path'
fs = require 'fs'

MonocleView = require './monocle-view'
MonocleEditor = require './monocle-editor'
MonocleEditorView = require './monocle-editor-view'
Parser = require './dsl/parser'

module.exports =
class MonocleTab
  constructor: (uri) ->
    @model = Parser.parse(fs.readFileSync(uri, 'utf8'))
    @title = path.basename(uri)
    @dir = path.dirname(uri)

  getTitle:     -> @title

  getViewClass: -> MonocleEditorView
