namespace :debug do
  desc 'Runs Sidekiq worker as a rake task'

  task :summary => :environment do
    my_worker = DailySummaryWorker.new
    my_worker.perform()
  end
end