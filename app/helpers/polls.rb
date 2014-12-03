helpers do
	def current_user_voted_for(poll)
		poll.options.each do |option|
			option.votes.each do |vote| 
				vote.backer.id == current_user.id ? (return vote) : next
				end
		end
		false
	end
end