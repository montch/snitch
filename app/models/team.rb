class Team < ActiveRecord::Base

  has_many :members
  belongs_to :org

end
