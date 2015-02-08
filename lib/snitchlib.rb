module Snitchlib
  # since we want to share these across controllers and workers...

  def get_events
    # distinct events from last feed
    # ForkEvent
    # PushEvent
    # DeleteEvent
    # PullRequestEvent
    # CreateEvent
    # IssueCommentEvent
    @events = @client.organization_events('ignitewithus')
    @events.each do |e|

      # this is just here so I can get an idea of what events we are using
      @etypes.push(e[:type]) unless @etypes.include?(e[:type])

      if @watched.has_value?(e[:repo][:id]) # sdc-hub = 24692629
        if e[:type] == "PushEvent" && e[:created_at] > @since
          dest = determine_event_holder(e)
          build_push_message(e, dest)
        end
      end
    end
  end

  def get_repos
    @repos = @client.repos
  end

  # TODO - make these next 2 methods smarter
  def get_watched_repos
    @repos.each do |r|
      if r.name.downcase == 'txtout'
        @watched.store('txtout', r.id)
      end
      if r.name.downcase == 'resumemonster'
        @watched.store('resumemonster', r.id)
      end
    end
  end

  def determine_event_holder(e)
    if e[:repo][:name].downcase.include?('txtout')
      return @txtout_events
    end
    if e[:repo][:name].downcase.include?('resumemonster')
      return @resmon_events
    end
  end

  def build_push_message(event, dest)
    notes = event[:payload][:commits].map { |c| c[:message] } || nil
    msg_out = " #{event.payload.size} ->  #{event.actor.login}  did  #{event.type}  to #{event.payload.ref_type} #{event.payload.ref.present? ? event.payload.ref.split("/").last : ''  } on #{event.created_at.in_time_zone("Eastern Time (US & Canada)").strftime('%r') } with notes: #{notes.join("' '")} "
    add_msg(msg_out, dest)
    tally_total(event.actor.login, event.payload.size)
  end

  def add_msg(msg, dest)
    dest.push(msg)
  end

  def tally_total(actor, size)
    if @totals.include?(actor)
      @totals["#{actor}"] = @totals["#{actor}"] + size
    else
      @totals.store("#{actor}", size)
    end
  end

  # TODO - this needs to be made smarter in conjunction woth the ones above
  def init_event_holders
    @txtout_events = Array.new
    @resmon_events = Array.new
  end

  def init_vars
    @etypes = Array.new
    @totals = Hash.new
    @watched = Hash.new
  end

  def init_client
    @client = Octokit::Client.new(:netrc => true) # from ~/.netrc
    @client.default_media_type = 'application/vnd.github.moondragon+json'  # tells github to use the newest api changes
    @client.auto_paginate = true
  end

  def determine_timeframe
    # default is the last 24 hours from runtime
    @since = DateTime.now - 1
  end




end