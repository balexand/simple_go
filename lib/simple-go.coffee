{BufferedProcess} = require 'atom'

atom.workspace.observeTextEditors (editor) ->
  editor.onDidSave (event) ->
    if event.path && event.path.match(/\.go$/)
      command = 'goimports'
      args = ['-w', event.path]
      stdout = (output) -> console.log(output)
      exit = (code) -> console.log("#{command} exited with #{code}")
      new BufferedProcess({command, args, stdout, exit})

module.exports =
  activate: ->
