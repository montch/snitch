class Member < ActiveRecord::Base
  belongs_to :team
  has_many :events
  has_one :org , through: :team

end
