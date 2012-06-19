# GET home page.
exports.index = (request, response) ->
  response.render 'index', { title: 'Chatanoo Notify' }