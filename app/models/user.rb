class User < ActiveRecord::Base
  has_many :surveys
  has_many :completions
  has_many :reponses
end
