get '/view/:token' do 
  @survey = Survey.find_by_token(params[:token])
  @questions = @survey.questions

	erb :view
end 

post '/view/:token' do
  survey_id = Survey.find_by_token(params[:token]).id
  Completion.create(user_id: current_user.id, survey_id: survey_id)
  responses = params[:options]
  responses.each do |option_id|
    Response.create(user_id: current_user.id, option_id: option_id)
  end
end
