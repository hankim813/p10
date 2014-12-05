get '/users/new' do
  redirect "families/#{current_family.id}/show?notice=you%20are%20logged%20in%20already" if current_user
  @key = params[:key]
  erb :'/users/new'
end

get '/users/:user_id' do
  require_user
  authenticate_user_access(params[:user_id])
  erb :"/users/show"
end

get '/users/:user_id/edit' do
  require_user
  authenticate_user_access(params[:user_id])
  erb :'/users/edit'
end

post '/users/new' do
  user = User.new(params[:user])
  url = upload(params[:content]['file'][:filename], params[:content]['file'][:tempfile])
  if user.save
    user.update_attribute(:profile_pic_link, url)
    family_key = SecureRandom.hex
    if params[:family][:password].nil? || params[:family][:password].empty?
      user.update_attributes(admin: true, family_key: family_key )
      set_session_id(user.id)
      redirect "/families/new"
    else
      set_session_id(user.id)
      if family = Family.find_by(token: params[:family][:password])
        user.update_attribute(:family_key, family_key)
        family.users << user
        redirect "/families/#{family.id}/show?notice=welcome%20to%20your%20family%20circle"
      else
        redirect "/families/new?notice=%20invalid%20family%20token"
      end
    end
  else
    redirect '/users/new?notice=user%20info%20was%20invalid.'
  end
end

put '/users/:user_id/edit' do
  require_user
  authenticate_user_access(params[:user_id])
  if current_user.authenticate(params[:user][:password])
    current_user.update_attributes(params[:user])
    redirect "/families/#{current_family.id}/show?notice=profile%20successfully%20updated"
  else
    @notice = "Password Incorrect"
    erb :"/users/edit"
  end
end