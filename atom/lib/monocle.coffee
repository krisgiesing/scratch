path = require 'path'
MonocleTab = require './monocle-tab'
{CompositeDisposable} = require 'atom'

module.exports = Monocle =
  monocleView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    atom.workspace.addOpener (uri) ->
      if path.extname(uri) is '.cmpt'
        return new MonocleTab(uri)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'monocle:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @monocleView.destroy()

  serialize: ->
    monocleViewState: @monocleView.serialize()

  toggle: ->
    console.log 'Monocle was toggled!'

    #if @modalPanel.isVisible()
    #  @modalPanel.hide()
    #else
    #  @modalPanel.show()
