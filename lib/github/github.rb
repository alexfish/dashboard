require 'octokit'

class GitHub

  def initialize
    settings = Sinatra::Application
    @client = Octokit::Client.new :access_token => settings.github['token']
  end

  def user
    @client.user.login
  end

  def issues(org=nil)
    options = {:state => "open", :filter => "all", :page => 0}
    page = 0
    count = 0
    # get a total count of org issues
    while @client.org_issues(org, options).length > 0 do
      options[:page] = page
      page = page + 1
      count = count + @client.org_issues(org, options).length
    end
    count
  end

end