helpers do
	def upload(filename, file)
		bucket = 'family-circle'
		AWS::S3::Base.establish_connection!(
			access_key_id: ENV['ACCESS_KEY_ID'],
			secret_access_key: ENV['SECRET_ACCESS_KEY']
		)
		AWS::S3::S3Object.store(
			filename,
			open(file.path),
			bucket
		)
		url = "https://#{bucket}.s3.amazonaws.com/#{filename}"
		return url
	end
end