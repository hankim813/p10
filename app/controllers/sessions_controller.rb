get '/sessions/new' do
  @notice = params[:notice]
  erb :'sessions/new'
end

post '/sessions/new' do
  if user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      set_session_id(user.id)
      redirect "/families/#{user.family.id}/show"
    else
      @notice = "Password is incorrect"
      erb :'/sessions/new'
    end
  else
    @notice = "User with this email does not exist"
    erb :'/sessions/new'
  end
end

delete '/sessions/destroy' do
  clear_session_id
  redirect '/'
end