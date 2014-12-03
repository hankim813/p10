get '/users/new' do
  redirect "families/#{current_user.family.id}/show?notice=you%20are%20logged%20in%20already" if current_user
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
  @user = current_family.users.find_by(id: current_user.id)
  erb :'/users/edit'
end

post '/users/new' do
  user = User.new(params[:user])
  if user.save
    set_session_id(user.id)
    if params[:family].nil?
      user.update_attribute(:admin, true)
      redirect "/families/new"
    else
      if family = Family.find_by(token: params[:family][:password])
        family.users << user
        redirect "/families/#{family.id}/show"
      else
        @notice = "Your family token must be invalid! Can't find your family!"
        erb :index
      end
    end
  else
    @notice = "Something went wrong. Please try again."
    erb :index
  end
end

put '/users/:user_id' do
  require_user
  authenticate_user_access(params[:user_id])
  user = current_family.users.find_by(id: params[:user_id])
  if user.authenticate(params[:user][:password])
    user.update_attributes(params[:user])
    redirect "/families/#{user.family.id}/show"
  else
    @notice = "Password Incorrect"
    erb :"/users/edit"
  end
end