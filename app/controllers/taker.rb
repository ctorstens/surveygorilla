get '/view/:token' do 
  @survey = Survey.find_by_token(params[:token])
  if @survey == nil
    redirect to(404)
  elsif cannot? :update, @survey and @survey.live == false
    redirect to(404)
  else
    @questions = @survey.questions.order('position')
    if current_user
      @completion = Completion.where("taker_id = ? AND survey_id = ?", current_user.id, @survey.id)
      @completed = @completion.any?
    end
  	erb :view
  end
end 

post '/view/:token' do
  p params
  survey_id = Survey.find_by_token(params[:token]).id
  if Completion.create(taker_id: current_user.id, survey_id: survey_id).valid?
    mcq_responses = params[:options]
    if mcq_responses
      mcq_responses.each do |question_id, option_id|
        Response.create(question_id: question_id, completion_id: Completion.last.id, option_id: option_id)
      end
    end

    text_responses = params[:answers]
    if text_responses
      text_responses.each do |question_id, answer|
        Response.create(question_id: question_id, completion_id: Completion.last.id, answer: answer)
      end
    end
  end
  redirect "/view/#{params[:token]}/survey_complete"
end

get '/view/:token/survey_complete' do
  erb :survey_complete
end

error 404 do 
  "The page is not found"
end


