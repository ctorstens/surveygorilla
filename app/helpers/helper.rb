helpers do
  def current_user
    if session[:id]
      @current_user ||= User.find(session[:id])
    end
  end

  # how to use helper ex:
  # <%= partial(:_survey_answer_completed, question: question) %>
  def partial(template, locals = {}, layout=false)
    erb(template, :layout => layout, :locals => locals)
  end

  def format_date(date)
    date.strftime("%Y/%M/%D %I:%M%p")
  end
end
