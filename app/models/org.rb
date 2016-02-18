# == Schema Information
#
# Table name: orgs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Org < ActiveRecord::Base
  has_many :teams
  has_many :members, through: :teams
end
