get '/profile' do
  @surveys = @current_user.surveys
	erb :profile
end

post '/survey' do
  survey = Survey.create
	redirect to("/survey/#{survey.token}")
end

get '/survey/:token' do
  @survey = Survey.find_by_token(params[:token])
	erb :survey
end

post '/survey/create' do
  survey = Survey.find_by_token(params[:survey][:token])
  survey.update_attributes(params[:survey], user: @current_user)

  questions = params[:questions]
  questions.each do |question|
    new_question = survey.questions.create(title: question["title"], help_text: question["help_text"])
    options = question["options"]
    options.each do |option|
      new_question.options.create(choice: option)
    end
  end

  redirect to('/profile')
end

get '/profile/:token' do

  erb :detail
end

get '/test' do end
  
