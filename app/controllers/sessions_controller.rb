# shows login page
get '/sessions/new' do
  erb :'/sessions/new'
end

# posts login info from the form and redirects appropriately
post '/sessions/new' do
  @user = User.find_by(username: params[:user][:username])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = ["Something went wrong."]
    erb :"/sessions/new"
  end
end

# logout
delete '/logout' do
  session[:user_id] = nil
  redirect '/'
end
