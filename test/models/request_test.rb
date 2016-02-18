# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  request    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  response   :json
#  caller     :string(255)
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
