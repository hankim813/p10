get '/families/:family_id/albums/new' do
	require_user
	authenticate_family_access(params[:family_id])
	@family = current_family
	erb :"/albums/new"
end

get '/families/:family_id/users/:user_id/albums/:album_id/edit' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if @album = current_family.albums.find_by(id: params[:album_id])
		@family = current_family
		erb :'/albums/edit'
	else
		redirect "/families/#{current_family.id}/show?notice=album%20not%20found#news-feed-anchor"
	end
end

get '/families/:family_id/albums/:album_id/show' do
	require_user
	authenticate_family_access(params[:family_id])
	if @album = current_family.albums.find_by(id: params[:album_id])
		@family = current_family
		erb :'/albums/show'
	else
		redirect "/families/#{current_family.id}/show?notice=album%20not%20found#news-feed-anchor"
	end
end

get '/families/:family_id/users/:user_id/albums/:album_id/photos/new' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if @album = current_family.albums.find_by(id: params[:album_id])
		@family = current_family
		erb :"/albums/after_create"
	else
		redirect "/families/#{current_family.id}/show?notice=album%20not%20found#news-feed-anchor"
	end
end

post '/families/:family_id/albums/new' do
	require_user
	authenticate_family_access(params[:family_id])
	album = Album.new(params[:album])
	if album.save
		current_user.albums << album
		params[:tags] ? (tags = params[:tags].split(",").map(&:strip)) : (redirect "/families/#{current_family.id}/users/#{current_user.id}/albums/#{album.id}/photos/new?notice=add%20some%20photos%20now#news-feed-anchor")
		tags.each do |tag_word|
			if tag = current_family.tags.find_by(word: tag_word.downcase)
				album.tags << tag
			else
				tag = Tag.new(word: tag_word.downcase, user_id: current_user.id)
				if tag.save
					album.tags << tag
				else
					redirect "/families/#{current_family.id}/show?notice=something%20went%20went%20wrong%20with%20the%20tag#news-feed-anchor"
				end
			end
		end
		redirect "/families/#{current_family.id}/users/#{current_user.id}/albums/#{album.id}/photos/new?notice=add%20some%20photos%20now#news-feed-anchor"
	else
		redirect "/families/#{current_family.id}/albums/new?notice=%20album%20no%20save#news-feed-anchor"
	end
end

put '/families/:family_id/users/:user_id/albums/:album_id/edit' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if album = current_family.albums.find_by(id: params[:album_id])
		if album.update_attributes(params[:album])
			redirect "/families/#{current_family.id}/show?notice=album%20successfully%20edited#news-feed-anchor"
		else
			redirect "/families/#{current_family.id}/show?something%20went%20wrong#news-feed-anchor"
		end
	else
		redirect "/families/#{current_family.id}/show?notice=album%20not%20found#news-feed-anchor"
	end
end

delete '/families/:family_id/users/:user_id/albums/:album_id/delete' do
	require_user
	authenticate_family_access(params[:family_id])
	authenticate_user_access(params[:user_id])
	if current_family.albums.find_by(id: params[:album_id]).destroy
		redirect "/families/#{current_family.id}/show?notice=album%20successfully%20deleted#news-feed-anchor"
	else
		redirect "/families/#{current_family.id}/show?notice=something%20went%20wrong#news-feed-anchor"
	end
end