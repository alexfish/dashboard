require './lib/jenkins/jenkins'

SCHEDULER.every '5s' do

  jenkins = Jenkins.new
  jobs = jenkins.tree("jobs[healthReport[score]]")

  total = 0

  jobs.each { |job|
    next if not job['healthReport']
    next if not job['healthReport'][0]
    next if not job['healthReport'][0]['score']

    total = job['healthReport'][0]['score'] + total
  }

  # if all jobs were at 100% then that is full health
  full_health = jobs.length * 100
  # figure out the current health percentage of the full health
  health = total.to_f / full_health.to_f * 100

  send_event('jenkins_health', { value: health })
end