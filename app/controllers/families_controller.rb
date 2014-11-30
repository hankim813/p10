
get '/families/new' do
  # associate the current user and this newly instantiated family using current user helper method
  erb :'/families/new'
end

get '/families/:family_id/show' do
  @family = Family.find(params[:family_id])
  erb :"/families/show"
end

post '/families/new' do
  family = Family.new(params[:family])
  if family.save
    redirect "/families/#{family.id}/show"
  else
    @notice = "Something went wrong, please try again"
    erb :'/families/new'
  end
end