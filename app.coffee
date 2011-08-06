###

###




settings = 
  domain: 'localhost:3000'

log = console.log

app = require('express').createServer()
http = require('http')
$ = require('jquery') 
mime = require('mime')

guetta = (req, res) ->
  # Fetch pre-domain (anything before featdavidguetta.com)
  # if there is no domain specified, show the front page
  # If there is a domain, getthe file portion of the URL and construct the full URL
  ###
  if req.headers.host = settings.domain
    log('show main site')
    res.render('index.jade', { title: 'My Site' });
  else
    getsite(res, req.headers.host, req.url)
  ###  
  log('Request for '+req.url)
  get_resource(res, 'www.reddit.com', req.url)  


get_resource = (res, host, path) ->
  # Get the third party resource at http://host/path and return the responses data
  log ''
  options =
    host: host
    path: path
  
  hasdot = path.indexOf '.'
  if hasdot == -1 
    log(hasdot+' assuming html: '+path)
    mime_type = 'text/html'
  else  
    log('Getting mime type from name'+path)
    mime_type = mime.lookup(path)

  log(mime_type)
  
  request = http.get options
  
  request.on 'response', (response) ->
    console.log("Got response: " + response.statusCode)
    data = ''
    response.on 'data', (chunk) -> 
      data += chunk
      
    response.on 'end', ->
      res.setHeader("Content-Type", mime_type)
      modify_page(res, data)

  request.on 'error', (error) ->
    console.log("Got error: " + error.message)
    res.send(error.message)

modify_page = (res, data) ->
  # Change relative image links to be full links
  res.send(data)    

app.get(/.*/, guetta)


app.listen(3000);






# Pull content and display it

# Add 'feat David Guetta' banner, audio tag, and video tag on higher z plane.


