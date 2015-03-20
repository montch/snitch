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

    SummaryMailer.send_summary(@txtout_events, @resmon_events, @repos, @totals).deliver!
  end

end



