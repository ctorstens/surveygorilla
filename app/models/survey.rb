class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :multiple_choices
  has_many :text_questions
  has_many :completions
  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex(4)
  end
end

