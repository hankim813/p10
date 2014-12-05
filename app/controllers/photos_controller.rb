get '/families/:family_id/photos/new' do
	require_user
	authenticate_family_access(params[:family_id])
	@family = current_family
	erb :"/photos/new"
end

get '/families/:family_id/users/:user_id/photos/:photo_id/edit' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if @photo = current_family.photos.find_by(id: params[:photo_id])
		@family = current_family
		erb :"/photos/edit"
	else
		redirect "/families/#{current_family.id}/show?notice=photo%20not%20found#news-feed-anchor"
	end
end

get '/families/:family_id/photos/:photo_id/show' do
	require_user
	authenticate_family_access(params[:family_id])
	if @photo = current_family.photos.find_by(id: params[:photo_id])
		@family = current_family
		erb :"/photos/show"
	else
		redirect "/families/#{current_family.id}/show?notice=photo%20not%20found#news-feed-anchor"
	end
end

post '/families/:family_id/photos/new' do
	require_user
	authenticate_family_access(params[:family_id])
	if url = upload(params[:content]['file'][:filename], params[:content]['file'][:tempfile])
		photo = Photo.new(caption: params[:caption], location: params[:location], src: url, user_id: current_user.id)
		if photo.save
			params[:tags] ? (tags = params[:tags].split(",").map(&:strip)) : (redirect "/families/#{current_family.id}/show?notice=photo%20successfully%20created#news-feed-anchor")
			tags.each do |tag_word|
				if tag = current_family.tags.find_by(word: tag_word.downcase)
					photo.tags << tag
				else
					tag = Tag.new(word: tag_word.downcase, user_id: current_user.id)
					if tag.save
						photo.tags << tag
					else
						redirect "/families/#{current_family.id}/show?notice=somethign%20went%20went%20wrong%20with%20the%20tag#news-feed-anchor"
					end
				end
			end
			redirect "/families/#{current_family.id}/show?notice=photo%20successfully%20uploaded#news-feed-anchor"
		else
			redirect "/families/#{current_family.id}/photos/new?notice=photo%20no%20save#news-feed-anchor"
		end
	else
		redirect "/families/#{current_family.id}/photos/new?notice=something%20went%20wrong%20with%20amazon%20servers#news-feed-anchor"
	end
end

post '/families/:family_id/users/:user_id/albums/:album_id/photos/new' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if url = upload(params[:content]['file'][:filename], params[:content]['file'][:tempfile])
		photo = Photo.new(caption: params[:caption], location: params[:location], src: url, user_id: current_user.id, album_id: params[:album_id])
		if photo.save
			params[:tags] ? (tags = params[:tags].split(",").map(&:strip)) : (redirect "/families/#{current_family.id}/users/#{current_user.id}/albums/#{params[:album_id]}/photos/new?notice=photo%20added%20to%20album#news-feed-anchor")
			tags.each do |tag_word|
				if tag = current_family.tags.find_by(word: tag_word.downcase)
					photo.tags << tag
				else
					tag = Tag.new(word: tag_word.downcase, user_id: current_user.id)
					if tag.save
						photo.tags << tag
					else
						redirect "/families/#{current_family.id}/users/#{current_user.id}/albums/#{params[:album_id]}/photos/new?notice=somethign%20went%20went%20wrong%20with%20the%20tag#news-feed-anchor"
					end
				end
			end
			redirect "//families/#{current_family.id}/users/#{current_user.id}/albums/#{params[:album_id]}/photos/new?notice=photo%20successfully%20uploaded#news-feed-anchor"
		else
			redirect "/families/#{current_family.id}/users/#{current_user.id}/albums/#{params[:album_id]}/photos/new?notice=photo%20no%20save#news-feed-anchor"
		end
	else
		redirect "/families/#{current_family.id}/users/#{current_user.id}/albums/#{params[:album_id]}/photos/new?notice=something%20went%20wrong%20with%20amazon%20servers#news-feed-anchor"
	end
end

put '/families/:family_id/users/:user_id/photos/:photo_id/edit' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if photo = current_family.photos.find_by(id: params[:photo_id])
		if photo.update_attributes(params[:photo])
			redirect "/families/#{current_family.id}/show?notice=photo%20successfully%20edited#news-feed-anchor"
		else
			redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong#news-feed-anchor"
		end
	else
		redirect "/families/#{current_family.id}/show?notice=photo%20not%20found#news-feed-anchor"
	end
end

delete '/families/:family_id/users/:user_id/photos/:photo_id/delete' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if current_family.photos.find_by(id: params[:photo_id]).destroy
		redirect "/families/#{current_family.id}/show?notice=photo%20successfully%20deleted#news-feed-anchor"
	else
		redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong#news-feed-anchor"
	end
end