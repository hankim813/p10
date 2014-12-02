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

  def authenticate_family_access
    family = Family.find_by(id: current_user.family.id)
    unless family.authenticate(current_user.family.id)
      redirect "/families/#{current_user.family.id}/show?notice=you%20have%20no%20access%20to%20that%20family"
      return
    end
  end
end