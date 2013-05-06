# require_relative "../models/ability"


get '/profile' do
  @surveys = @current_user.surveys
  @live_surveys = @surveys.select { |survey| survey.live == true }
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

get '/edit' do
  if params[:type] == "survey"
    @survey = Survey.find_by_token(params[:token])
    erb :edit_survey
  elsif params[:type] == "question"
    @question = Question.find(params[:id])
    erb :edit_question
  end
end

post '/edit/survey' do
  survey = Survey.find_by_token(params[:survey][:token])
  survey.update_attributes(params[:survey])
  redirect to('/profile')
  200
end

post '/edit/question' do
  p params
  questions = params[:questions][0]
  question = Question.find(params[:questions][0]["id"])
  question.update_attributes(title: questions["title"], help_text: questions["help_text"], type: questions["type"])
  option_ids = params[:option_ids]
  questions["options"].each_with_index do |choice, index| 
    Option.find(option_ids[index]).update_attributes(choice: choice)
  end
  redirect to('/view/7cf60f52')
  200
end





get '/launch' do
  survey = Survey.find_by_token(params[:token])
  survey.live = true
  survey.save
  redirect to('/profile')
end
