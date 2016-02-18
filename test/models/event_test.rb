# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  member_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#  git_id       :string(255)
#  raw          :json
#  git_type     :string(255)
#  git_actor    :string(255)
#  git_actor_id :string(255)
#  git_repo     :string(255)
#  git_repo_id  :string(255)
#  event_at     :datetime
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
