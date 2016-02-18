# == Schema Information
#
# Table name: members
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  email        :string(255)
#  first_name   :string(255)
#  last_name    :string(255)
#  github_login :string(255)
#  deactivated  :boolean
#  created_at   :datetime
#  updated_at   :datetime
#  avatar_url   :string(255)
#  github_id    :string(255)
#  alias_list   :string(255)
#

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
