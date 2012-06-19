# Module dependencies.
express = require('express')
ejs = require('ejs')
routes = require('./routes')

app = express.createServer()

# Socket.IO
io = require('socket.io').listen app

# Configuration
app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'ejs'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + '/public')

app.configure 'development', ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
	app.use express.errorHandler()

# Routes
app.get '/', routes.index 

# POST emit page.
app.post '/emit', (request, response) ->
	io.sockets.emit request.body.name, JSON.parse( request.body.data )
	response.render 'emit', { title: 'Chatanoo Notify' }

if app.settings.env is 'development'
	app.listen 3001, ->
  	console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env

exports.app = app