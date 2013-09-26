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
    issues = 0

    # get a total count of org issues
    loop do
      options[:page] = page
      page = page + 1
      issues = @client.org_issues(org, options).length
      count = count + issues
      break if issues == 0
    end
    count
  end

end