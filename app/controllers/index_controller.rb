get '/' do
	redirect "/families/#{current_family.id}/show" if current_user
  # Landing Page
  erb :index
end

post '/fb/api/users' do
	if User.find_by(email: params["email"])
		{ email: params["email"], notice: "You already have an account" }.to_json
	else
		redirectLink = "/users/new?first_name=" + params["first_name"] + "&last_name=" + params["last_name"] + "&email="
		email.gsub!('.', '%2E')
		email.gsub!('@', '%40')
		(redirectLink + email).to_json
	end
end