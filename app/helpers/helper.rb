helpers do
  def current_user
    if session[:id]
      @current_user ||= User.find(session[:id])
    end
  end

  def partial(template, locals = {}, layout=false)
    erb(template, :layout => layout, :locals => locals)
  end

  def formate_date(date)
    date.strftime("%Y/%M/%D %I:%M%p")
  end
end
