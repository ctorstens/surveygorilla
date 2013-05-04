class Response < ActiveRecord::Base
  belongs_to :completion
  belongs_to :question
  belongs_to :option
end
