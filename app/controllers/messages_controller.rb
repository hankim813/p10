get '/families/:family_id/users/:user_id/inbox' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	@family = current_family
	erb :"/private_convos/index"
end

post '/families/:family_id/users/:user_id/recipient/:recipient_id/messages/new' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	@family = current_family
	message = Message.new(description: params[:description], user_id: current_user.id, recipient_id: params[:recipient_id])
	if message.save
		redirect "/families/#{current_family.id}/users/#{current_user.id}/inbox?notice=message%20sent"
	else
		redirect "/families/#{current_family.id}/users/#{current_user.id}/inbox?notice=message%20could%20not%20be%20sent"
	end
end