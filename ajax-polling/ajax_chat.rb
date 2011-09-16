require 'sinatra'
require 'json'
require 'erubis'

set :public, File.dirname(__FILE__) + '/public'

$chatters = {}

get '/' do
  @id = $chatters.length
  $chatters[@id.to_s] = []
  erubis :index
end

get '/updates/:id' do
  messages = $chatters[params[:id]]
  $chatters[params[:id]] = []
  messages.to_json
end

post '/message' do
  $chatters.each do |k, v|
    $chatters[k] = v.push(params[:message])
  end
  'ok'
end

__END__

@@index
<html>
  <head>
<!--    <link rel="stylesheet" href="http://twitter.github.com/bootstrap/assets/css/bootstrap-1.2.0.min.css"> -->
    <script type="text/javascript" src="/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="/chat.js"></script>
    <title>Ajax Chat</title>
  </head>
  <body>
    <form>
      <input name="chat-id" id="chat-id" type="hidden" value="<%= @id %>"/>
      <input name="message" id="message" type="text"/>
      <input name="submit" type="submit" value="Send"/>
    </form>
    <ul id="messages"></ul>
  </body>
</html>
