path = require 'path'
fs = require 'fs'

MonocleView = require './monocle-view'
MonocleEditor = require './monocle-editor'
MonocleEditorView = require './monocle-editor-view'
ADIN = require './adin/parser'

module.exports =
class MonocleTab
  constructor: (uri) ->
    @model = ADIN.parse(fs.readFileSync(uri, 'utf8'))
    @title = path.basename(uri)
    @dir = path.dirname(uri)

  getTitle:     -> @title

  getViewClass: -> MonocleEditorView
