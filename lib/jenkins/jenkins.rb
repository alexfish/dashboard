require 'json'
require 'net/http'
require 'uri'

class Jenkins

  def initialize
    @settings = Sinatra::Application
  end

  # Returns the tree response array from the jenkins API
  def jobs
    response = request("?depth=1")
    # get the JSON key from the tree by removing the branch
    response = JSON.parse(response.body)["jobs"]

    response
  end

  # Sends a request to Jenkins and returns the response
  def request(path)
    url  = URI.parse(@settings.jenkins['url'])
    http = Net::HTTP.new(url.host, url.port)

    if ('https' == url.scheme)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    api_url = "%s/view/%s/api/json#{path}" \
              % [ @settings.jenkins['url'].chomp('/'), @settings.jenkins['view'] ]
    response = http.request(Net::HTTP::Get.new(api_url))
    response
  end

end