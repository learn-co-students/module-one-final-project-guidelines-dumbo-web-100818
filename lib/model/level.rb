class Level < ActiveRecord::Base
has_many :scores
has_many :runners, through: :scores
end
