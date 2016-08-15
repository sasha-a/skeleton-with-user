get "/sessions/login" do
  erb :"/sessions/login"
end

# rout should be /session
post "/sessions/login" do
  @user = User.find_by(email: params['user'][:email])

  if @user && @user.authenticate(params['user'][:password])
    session[:user_id] = @user.id
    redirect "/users/show"
  else
    @errors = ["Seomething went wrong"]
    erb :"/sessions/login"
  end
end

delete "/sessions/logout" do
  session[:user_id] = nil
  redirect "/"
end
