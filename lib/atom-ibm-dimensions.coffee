AtomIbmDimensionsView = require './atom-ibm-dimensions-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomIbmDimensions =
  atomIbmDimensionsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomIbmDimensionsView = new AtomIbmDimensionsView(state.atomIbmDimensionsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomIbmDimensionsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-ibm-dimensions:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomIbmDimensionsView.destroy()

  serialize: ->
    atomIbmDimensionsViewState: @atomIbmDimensionsView.serialize()

  toggle: ->
    console.log 'AtomIbmDimensions was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
