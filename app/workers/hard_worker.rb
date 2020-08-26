class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts "#{name} did his job in #{count} hours"
  end
end
