require './lib/jenkins/jenkins'
require './lib/github/github'

current_issues = 0

SCHEDULER.every '5s' do
  github = GitHub.new

  last_issues = current_issues
  current_issues = github.issues(settings.github['org'])

  send_event('github_issues', { current: current_issues, last: last_issues })
end