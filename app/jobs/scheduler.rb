require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new
puts "Scheduler is initiated..."

# example
# if ENV.fetch('LOCKED_FOLDER_REEXECUTION') == "true"
#   scheduler.every '1m', overlap: false, tag: REEXECUTE_LOCKED_FOLDERS do
#     Log.info "[ESB Plugin Scheduler] #{Time.now} --> Running the job #{REEXECUTE_LOCKED_FOLDERS}"
#     ReexecuteLockedFolders.new.call
#   end
# end

scheduler.every '10s' do
  puts "Hello, it's #{Time.now}"
end

def scheduler.on_error(job, error)
  Rails.logger.error("SchedulerError on #{Time.now}. Rufus-scheduler intercepted #{error.inspect} in #{job.opts[:tag]}")
  Rails.logger.error "#{error.backtrace}"
end

scheduler.join
