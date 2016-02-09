path = require 'path'
fs = require 'fs'

MonocleView = require './monocle-view'
MonocleEditor = require './monocle-editor'
MonocleEditorView = require './monocle-editor-view'

module.exports =
class MonocleTab
  constructor: (uri) ->
    @model = JSON.parse(fs.readFileSync(uri))
    @title = path.basename(uri)
    @dir = path.dirname(uri)

  getTitle:     -> @title

  getViewClass: -> MonocleEditorView
