get '/families/:family_id/photos/new' do
	require_user
	authenticate_family_access(params[:family_id])
	erb :"/photos/new"
end

get '/families/:family_id/photos/:photo_id/edit' do
	require_user
	authenticate_family_access(params[:family_id])
	if @photo = current_family.photos.find_by(id: params[:photo_id])
		erb :"/photos/edit"
	else
		redirect "/families/#{current_family.id}/show?notice=photo%20not%20found"
		return
	end
end

get '/families/:family_id/photos/:photo_id/show' do
	require_user
	authenticate_family_access(params[:family_id])
	if @photo = current_family.photos.find_by(id: params[:photo_id])
		erb :"/photos/show"
	else
		redirect "/families/#{current_family.id}/show?notice=photo%20not%20found"
		return
	end
end

post '/families/:family_id/users/:user_id/photos/upload' do
	require_user
	authenticate_family_access(params[:family_id])
	if url = upload(params[:content]['file'][:filename], params[:content]['file'][:tempfile])
		photo = Photo.new(caption: params[:caption], location: params[:location], src: url, user_id: current_user.id)
		if photo.save
			redirect "/families/#{current_family.id}/show?notice=photo%20successfully%20uploaded"
			return
		else
			redirect "/families/#{current_family.id}/photos/new?notice=photo%20no%20save"
			return
		end
	else
		redirect "/families/#{current_family.id}/photos/new?notice=something%20went%20wrong%20with%20amazon%20servers"
		return
	end
end

put '/families/:family_id/photos/:photo_id/edit' do
	require_user
	authenticate_family_access(params[:family_id])
	if photo = current_family.photos.find_by(id: params[:photo_id])
		if photo.update_attributes(params[:photo])
			redirect "/families/#{current_family.id}/show?notice=photo%20successfully%20edited"
			return
		else
			redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
			return
		end
	else
		redirect "/families/#{current_family.id}/show?notice=photo%20not%20found"
		return
	end
end

delete '/families/:family_id/photos/:photo_id/delete' do
	require_user
	authenticate_family_access(params[:family_id])
	if current_family.photos.find_by(id: params[:photo_id]).destroy
		redirect "/families/#{current_family.id}/show?notice=photo%20successfully%20deleted"
		return
	else
		redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong"
		return
	end
end