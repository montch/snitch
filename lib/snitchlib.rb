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
    total = 0;
    @events = @client.organization_events(org_name)
    @events.each do |e|

      # this is just here so I can get an idea of what events we are using
      @etypes.push(e[:type]) unless @etypes.include?(e[:type])

      if @watched.has_value?(e[:repo][:id]) # sdc-hub = 24692629
        if e[:type] == "PushEvent" && e[:created_at] > @since

          e[:payload][:commits].each do |c|
            # @shas.push({e[:repo][:id] => c[:sha]})
            total = total + get_sha_stats(e[:repo][:id], c[:sha])
          end
          dest = determine_event_holder(e)
          build_push_message(e, dest, total)
        end
      end
    end
  end

  def org_name
    org =init_org
    org.name
  end


  def get_sha_stats(repo_id, sha)
    @repos.each do |r|
      if r[:id] == repo_id
        total = r.rels[:commits].get(:uri => {sha: sha}).data.stats[:total]
        return total.to_i
      end
    end
  end

  def get_stats
    #/repos/:owner/:repo/stats/contributors
    #@repos.first.rels[:statuses].get.data
    @repos.each do |r|
      if @watched.has_value?(r[:id]) #&& @shas.include?(r[:id])
        @shas.each do |s|
          # stats = r.rels[:statuses].get.data(v)
          if s.include?(r[:id])
            r.rels[:commits].get(:uri => {sha: s[r[:id]]}).data.stats[:total]
          end
        end
        #stats = r.rels[:statuses].get.data
        # stats
      end
    end

    #  @watched.rels[:statuses].get.data
    # @watched
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

  def build_push_message(event, dest, total)
    notes = event[:payload][:commits].map { |c| c[:message] } || nil
    msg_out = "#{event.actor.login}  added #{total} lines of code at #{event.created_at.in_time_zone("Eastern Time (US & Canada)").strftime(('%l:%M %p')) } to  #{event.payload.ref_type} #{event.payload.ref.present? ? event.payload.ref.split("/").last : ''  } with notes: \"#{notes.join("' '")}\"   "
    add_msg(msg_out, dest)
    tally_total(event.actor.login, total)
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

  # TODO - this needs to be made smarter in conjunction with the ones above
  def init_event_holders
    @txtout_events = Array.new
    @resmon_events = Array.new
  end

  def init_vars
    @etypes = Array.new
    @totals = Hash.new
    @watched = Hash.new
    @shas = Array.new
  end

  def init_client
 #   @client = Octokit::Client.new(:netrc => true) # from ~/.netrc
    @client = Octokit::Client.new(:access_token => Rails.application.config.github_access_token)
    @client.default_media_type = 'application/vnd.github.moondragon+json' # tells github to use the newest api changes
    @client.auto_paginate = true
  end

  def determine_timeframe
    # default is the last 24 hours from runtime
    @since = DateTime.now - 1
  end

  def get_members
    init_org if @org.blank?
    @client.organization_members(@org.name)
  end

  # Just creating 1 team for now, leaving room to flesh this out if needed
  # called from init_members.rake for now
  def init_teams
    init_org if @org.blank?
    @team = Team.where('name is NOT NULL').first_or_create(name: 'development', org_id: @org.id)
  end

  #just doing 1 org at the moment
  def init_org
    @org = Org.where('name is NOT NULL').first_or_create(name: Rails.application.config.github_org)
  end


  def get_org_events
    resp = @client.organization_events(org_name)
    log_this
    resp
  end


  def log_this
    return if @client.blank?
    Request.create(request: @client.last_response.headers[:link], response: @client.last_response.as_json, caller: caller_locations(1,1)[0].label  )
  end
end