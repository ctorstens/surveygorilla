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


#refactor later to transform the form of the object
post '/survey/create' do
  survey = Survey.find_by_token(params[:survey][:token])
  params[:survey][:user] = @current_user
  p params
  survey.update_attributes(params[:survey])
  p survey
  questions = params[:questions]
  questions.each do |question|
    new_question = survey.questions.create(title: question["title"], help_text: question["help_text"], type: question["type"])
    if new_question.type == "MultipleChoice"
      new_question = MultipleChoice.find(new_question.id) 
      options = question["options"]
      options.each { |option| new_question.options.create(choice: option) }    
    end
  end
  redirect to('/profile')
end

get '/profile/:token' do
  erb :detail
end



    # p params
    # p params[:questions]
    # p question["type"]
    # p new_question
    # 
