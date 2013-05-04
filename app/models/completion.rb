class Completion < ActiveRecord::Base
  belongs_to :taker, class_name: "User", foreign_key: "taker_id"
  belongs_to :survey
  has_many :responses

  validates_uniqueness_of :taker_id, :scope => :survey_id
end
