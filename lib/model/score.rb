class Score < ActiveRecord::Base
  belongs_to :runner
  belongs_to :level
end
