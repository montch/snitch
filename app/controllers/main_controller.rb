class MainController < ApplicationController
  include Snitchlib

  def index
    init_vars
    init_client
    determine_timeframe
    get_repos
    get_watched_repos
    init_event_holders
    get_events
  end

end


