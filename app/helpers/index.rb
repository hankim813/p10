helpers do 
	def render_news(model)
		case model.class.model_name.human
		when "Post"
			erb :"/posts/_show", locals: { post: model }
		when "Poll"
			erb :"/polls/_show", locals: { poll: model }
		when "Photo"
			erb :"/photos/_show", locals: { photo: model }
		when "Album"
			erb :"/albums/_show", locals: { album: model }
		end
	end
end