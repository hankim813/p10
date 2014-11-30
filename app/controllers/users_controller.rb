get '/users/new' do
  erb :'/users/new'
end

get '/users/:user_id' do

end

post '/users/new' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    if user.family.nil?
      user.update_attribute(:admin, true)
      redirect "/families/new"
    else
      if family = Family.find_by(token: params[:user][:family_id])
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