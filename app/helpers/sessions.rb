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

  def authenticate_family_access(family_id)
    if family = Family.find_by(id: family_id)
      family.authenticate(current_user.family.id)
    else
      redirect "/families/#{current_user.family.id}/show?notice=you%20have%20no%20access%20to%20that%20family"
      return
    end
  end

  def authenticate_user_access(user_id)
    redirect "/families/#{current_user.family.id}/show?notice=you%20have%20no%20access" unless current_user.id == user_id.to_i
  end

  def authenticate_current_user_access_to(object)
    object.user.id == current_user.id
  end
end