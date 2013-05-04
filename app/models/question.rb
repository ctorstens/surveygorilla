class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses
end


class MultipleChoice < Question
  has_many :options
end

class TextQuestion < Question
end
