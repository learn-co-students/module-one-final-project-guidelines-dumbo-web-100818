class Runner < ActiveRecord::Base
has_many :scores
has_many :levels, through: :scores
end
