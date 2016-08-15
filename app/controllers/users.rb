get "/users/new" do
  @user = User.new
  erb :"/users/new"
end

post '/users' do
  @user = User.new(params["user"])
  if @user.save
    redirect "/"
  else
    @errors = @user.errors.full_messages
    erb :"/users/new"
  end
end

get "/users/:id" do
	@user= User.find_by(id: params[:id])
	if @user
		erb :"/users/show"
	else
		redirect "/"
	end
end

### add subscription
# @user.channels << @channel
### delete subscriptions
# delete
#   @subscription = subscription.find_by(id: params[:id])
#   @subscription.destrioy
