letters = ('a'..'z').to_a

User.create(username: "test", email: "test@dbc.com", password: "password", token: "123");
20.times do
  User.create(username: Faker::Internet.user_name, email: Faker::Internet.email, password: Faker::Lorem.word, token: letters.sample(4).join)
end

users = User.all
100.times do
  Survey.create(user_id: users.sample.id, title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, token: letters.sample(4).join)
end

surveys = Survey.all
100.times do
  Completion.create(user_id: users.sample.id, survey_id: surveys.sample.id)
end

500.times do
  Question.create(survey_id: surveys.sample.id, title: Faker::Lorem.sentence, help_text: Faker::Lorem.paragraph)
end

questions = Question.all
1000.times do
  Option.create(question_id: questions.sample.id, choice: ('a'..'d').to_a.sample)
end

options = Option.all
500.times do
  Response.create(user_id: users.sample.id, option_id: options.sample.id)
end
