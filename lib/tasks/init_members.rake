require 'snitchlib'
include Snitchlib

namespace :db do
  desc 'Load in the members of the org into the DB'

  task :init_members => :environment do
    init_vars
    init_client
    Team.first.blank? ? init_teams : @team = init_teams
    get_members.each do |m|
      Member.where(github_login: m.login).first_or_create(github_login: m.login, avatar_url: m.avatar_url, github_id: m.id, team_id: @team.id, alias_list: m.login.downcase )
    end
  end
end