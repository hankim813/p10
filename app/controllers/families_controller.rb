
get '/families/new' do
  erb :'/families/new'
end

get '/families/:family_id/show' do
  @family = Family.find(params[:family_id])
  erb :"/families/show"
end

post '/families/new' do
  family = Family.new(params[:family])
  user = current_user
  if family.save
    user.family = family
    user.save
    family.password = user.family.id
    redirect "/families/#{user.family.id}/show"
  else
    @notice = "Something went wrong, please try again"
    erb :'/families/new'
  end
end