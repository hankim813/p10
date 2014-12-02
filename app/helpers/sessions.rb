helpers do
  def current_user
    session["user_id"].nil? ? false : (User.find(session["user_id"]))
  end

  def set_session_id(user_id)
    session["user_id"] = user_id
  end

  def require_user
    redirect "/sessions/new?notice=you%20must%20sign%20in" unless current_user
  end
end