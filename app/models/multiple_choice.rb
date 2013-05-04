class MultipleChoice < Question
  has_many :options, foreign_key: "question_id"
end
