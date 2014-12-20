SimpleGoView = require './simple-go-view'
{CompositeDisposable} = require 'atom'

module.exports = SimpleGo =
  simpleGoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @simpleGoView = new SimpleGoView(state.simpleGoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @simpleGoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'simple-go:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @simpleGoView.destroy()

  serialize: ->
    simpleGoViewState: @simpleGoView.serialize()

  toggle: ->
    console.log 'SimpleGo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
