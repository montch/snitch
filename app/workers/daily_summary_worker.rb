class DailySummaryWorker
  include Sidekiq::Worker
  include Snitchlib

  def perform( )
    init_vars
    init_client
    determine_timeframe
    get_repos
    get_watched_repos
    init_event_holders
    get_events


    SummaryMailer.send_summary().deliver
  end

end

#Sidekiq::Cron::Job.create(name: 'Hard worker - every 5min', cron: '*/5 * * * *', klass: 'HardWorker')

