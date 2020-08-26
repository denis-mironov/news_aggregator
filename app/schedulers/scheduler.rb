require 'rufus-scheduler'
require_relative '../../config/application'
require_relative '../../config/environments/development'
require_all 'app/workers'

scheduler = Rufus::Scheduler.new
Rails.logger.info("Scheduler is initiated...")

scheduler.every '10s' do
  HardWorker.perform_async('JIM', 10)
end

def scheduler.on_error(job, error)
  Rails.logger.error("SchedulerError on #{Time.now}. Rufus-scheduler intercepted #{error.inspect}")
  Rails.logger.error "#{error.backtrace}"
end

scheduler.join
