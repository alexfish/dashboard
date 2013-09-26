require './lib/jenkins/jenkins'

SCHEDULER.every '5s' do

  jenkins = Jenkins.new
  jobs = jenkins.jobs

  total = 0

  statuses = {}

  jobs.each { |job|
    next if not job['color']
    next if not job['name']

    status = ""

    case job['color']
      when "red"
        status = "Very Bad"
      when "blue"
        status = "All good"
      when "yellow"
        status = "Not so good"
      when "disabled"
        status = "Disabled"
      when "aborted"
        status = "Something is wrong"
    end

    statuses[job['name']] = {label: job['name'], value: status}
  }

  send_event('jenkins_status', { items: statuses.values })
end