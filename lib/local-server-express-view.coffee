{View} = require 'atom'

module.exports =
class LocalServerExpressView extends View
  @content: ->
    @div class: 'local-server-express overlay from-top', =>
      @div "local-server-express", class: "message"
  initialize: (serializeState) ->
    atom.workspaceView.command "local-server-express:run", => @start()

  serialize: ->

  destroy: ->
    @detach()

  start: ->
    @getPort()

  getPort: ->
    portfinder = require 'portfinder'

    portfinder.getPort (err, port) =>
      @startServer port

  startServer: (port) ->
    open = require 'open'
    express = require 'express'
    app = express()
    serveIndex = require 'serve-index'
    projectPath = atom.project.getPath()
    app.use express.static projectPath
    app.use serveIndex projectPath,
      icons: true
    
    app.listen port
    
    open "http://localhost:#{port}"
