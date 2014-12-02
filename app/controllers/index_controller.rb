get '/' do
	redirect "/families/#{current_user.family.id}/show" if current_user
	require_relative "../../config"
	@app_id = APP_ID
  # Landing Page
  erb :index
end

get '/api/fb/user' do
	p params
end

