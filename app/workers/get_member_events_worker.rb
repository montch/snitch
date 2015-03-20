class GetMemberEventsWorker
  include Sidekiq::Worker
  include Snitchlib

  def perform()

    p "Running GetMemberEventsWorker"
    init_vars
    init_client
    determine_timeframe
    get_org_events.each do |e|
      member = Member.find_by_github_id(e.actor.id.to_s)
      next if member.blank?
      Event.where(git_id: e.id).first_or_create(raw: e.to_json, git_id: e.id, member_id: member.id, git_type: e.type, git_actor: e.actor.login, git_actor_id: e.actor.id, git_repo: e.repo.name, git_repo_id: e.repo.id, event_at: e.created_at)
    end


  end

end



Sidekiq::Cron::Job.create( name: 'GetMemberEventsWorker', cron: '*/2 * * * *', klass: 'GetMemberEventsWorker')