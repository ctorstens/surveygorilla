User.create(username: "test", email: "test@dbc.com", password: "password");

20.times do
  User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: Faker::Lorem.word)
end

users = User.all

# survey creation
100.times do
  Survey.create(user_id: users.sample.id, title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
end

surveys = Survey.all

surveys.each do |survey|
  10.times do |i|
    i+=1
    survey.questions.create(title: Faker::Lorem.sentence, help_text: Faker::Lorem.paragraph, type: ["MultipleChoice","TextQuestion"].sample, position: i, required: [true,false].sample)
  end
end

multiple_choice_questions = MultipleChoice.all

multiple_choice_questions.each do |mcq|
  5.times do |i|
    mcq.options.create(choice: Faker::Company.name)
  end
end





# completing a survey by a user
# 5.times do
#   surveys.each do |survey|
#     if survey.completions.create(taker_id: users.sample.id)
#       survey.questions.each do |question|
#         taker = survey.takers


#         if question.type == "MultipleChoice"
#           question.responses.create(:)
#         elsif question.type == "TextQuestion"

#         end
#       end
#     end
#   end
# end

# multiple_choice_questions = MultipleChoice.all
# text_questions = TextQuestion.all

# survey.questions.each do 


#   multiple_choice_questions.each do |mcq|
#     mcq.responses.create()
#   end

