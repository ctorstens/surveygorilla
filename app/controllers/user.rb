# require_relative "../models/ability"


get '/profile' do
  p "profile"
  @surveys = @current_user.surveys
  @live_surveys = @surveys.select { |survey| survey.live == true }
  p "profile"
  p @live_surveys
  @draft_surveys = @surveys.select { |survey| survey.live != true }
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
  survey.update_attributes(params[:survey])
  questions = params[:questions]
  questions.each do |question|
    new_question = survey.questions.create(title: question["title"], help_text: question["help_text"], type: question["type"], required: question["required"], position: question["position"])
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

get '/analytics/:token' do
  @survey = Survey.find_by_token(params[:token])
  @mcq = @survey.multiple_choices
  @tq = @survey.text_questions
  erb :analytics
end

get '/edit/:token' do
  @survey = Survey.find_by_token(params[:token])
  @questions = @survey.questions
  erb :edit
end

post '/edit' do

end


get '/launch' do
  survey = Survey.find_by_token(params[:token])
  survey.live = true
  survey.save
  redirect to('/profile')
end
