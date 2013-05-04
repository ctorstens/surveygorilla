class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses

  def self.attributes_protected_by_default
    ["id"]
  end
end




