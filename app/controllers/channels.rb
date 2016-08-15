get '/' do
  @channels = Channel.all
  erb :"/channels/index"
end

get '/channels/:id' do
	@channel = Channel.find(params[:id])
	if @channel
		erb :"/channels/show"
	else
		redirect "/"
	end
end
