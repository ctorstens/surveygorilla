class Option < ActiveRecord::Base
  belongs_to :question
  belongs_to :multiple_choice, class_name: "Question", foreign_key: "question_id"
  has_many :responses
end
