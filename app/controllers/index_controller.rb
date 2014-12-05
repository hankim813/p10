get '/' do
	redirect "/families/#{current_family.id}/show" if current_user
  @notice = params[:notice]
  erb :index
end

post '/send' do
	Pony.mail({
  :to 										=> 'hankim813@gmail.com',
  :from 									=> 'noreply-circle@p10.herokuapp.com',
  :subject 								=> 'hi from circle',
  :body 									=> 'hello!',
  :via 										=> :smtp,
  :via_options => {
    :address        			=> 'smtp.mandrillapp.com',
    :port           			=> '587',
    :user_name      			=> ENV['MANDRILL_USERNAME'],
    :password       			=> ENV['MANDRILL_PASSWORD'],
    :authentication 			=> :plain, 
    :domain         			=> 'localhost:9393',
    :enable_starttls_auto => true
	  }
	})
	@family = current_family
	redirect "/families/#{current_family.id}/show"
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