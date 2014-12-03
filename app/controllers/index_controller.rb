get '/' do
	redirect "/families/#{current_user.family.id}/show" if current_user
  # Landing Page
  erb :index
end

post '/fb/api/users' do
	redirectLink = "/users/new?first_name=" + params["first_name"] + "&last_name=" + params["last_name"] + "&email="
	email = params["email"]
	email.gsub!('.', '%2E')
	email.gsub!('@', '%40')
	(redirectLink + email).to_json
end