20.times do
  User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: Faker::Lorem.word)
end
users = User.all

test_user = User.create(username: "test", email: "test@dbc.com", password: "password");

# survey creation
5.times do
  Survey.create(user: test_user, title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, live: true, expiry_date: (Time.now + 2000000))
end

5.times do
  Survey.create(user: test_user, title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, live: false, expiry_date: [(Time.now + 2000000),nil].sample)
end

surveys = Survey.all

surveys.each do |survey|
  10.times do |i|
    i+=1
    survey.questions.create(title: Faker::Lorem.sentence, help_text: Faker::Lorem.paragraph, type: ["MultipleChoice","MultipleChoice","MultipleChoice","MultipleChoice","TextQuestion"].sample, position: i, required: [true,false].sample)
  end
end

multiple_choice_questions = MultipleChoice.all

multiple_choice_questions.each do |mcq|
  5.times do |i|
    mcq.options.create(choice: Faker::Company.name)
  end
end

# seeding completed surveys

# completing a survey by a user

test_survey = Survey.find(1)

users.each do |user| 
  if test_survey.completions.create(taker: user).valid?
    test_survey.multiple_choices.each do |mcq|
      Response.create(question: mcq, completion: Completion.last, option: mcq.options.sample)    
    end
    test_survey.text_questions.each do |tq|
      tq.responses.create(completion: Completion.last, answer: Faker::Lorem.sentence)
    end
  end
end
