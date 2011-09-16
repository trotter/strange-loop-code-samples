require 'sinatra'
require 'json'
require 'erubis'
require 'net/http'

set :public, File.dirname(__FILE__) + '/public'

get '/' do
  erubis :index
end

post '/updates' do
  params = Hash[URI.decode_www_form(request.body.read)]
  Net::HTTP.post_form(URI.parse("http://localhost:8901/send"),
                      {"data" => params["message"]})
  'ok'
end

__END__

@@index
<html>
  <head>
<!--    <link rel="stylesheet" href="http://twitter.github.com/bootstrap/assets/css/bootstrap-1.2.0.min.css"> -->
    <script type="text/javascript" src="/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="http://localhost:8901/chloe.js"></script>
    <script type="text/javascript" src="/chat.js"></script>
    <title>Chloe Chat</title>
  </head>
  <body>
    <form>
      <input name="message" id="message" type="text"/>
      <input name="submit" type="submit" value="Send"/>
    </form>
    <ul id="messages"></ul>
  </body>
</html>
