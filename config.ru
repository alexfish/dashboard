require 'dashing'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'
  set :jenkins, {
    'url'  => 'http://localhost:8080',
    'view' => 'All'
  }
  set :github, {
    'token' => ''
    'org' => ''
  }
  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application