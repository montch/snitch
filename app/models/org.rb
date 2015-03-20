class Org < ActiveRecord::Base
  has_many :teams
  has_many :members, through: :teams
end
