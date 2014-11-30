helpers do
  def current_user
    session["user_id"].nil? ? false : (User.find(session["user_id"]))
  end

  def set_session_id(user_id)
    sessions["user_id"] = user_id
  end
end