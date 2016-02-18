# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  org_id     :integer
#

class Team < ActiveRecord::Base

  has_many :members
  belongs_to :org

end
