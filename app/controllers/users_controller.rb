# registration
get '/users/new' do
  erb :'/users/new'
end

# registration form
post '/users' do
  @user = User.new(params[:user])
  if @user.save
    # session[:user_id] = @user.id
    redirect "/"
  else
    @errors = @user.errors.full_messages
    erb :"/users/new"
  end
end

# display a specific user (profile page)
get '/users/:id' do
  ensure_login!
  @user = User.find_by(id: params[:id])
  erb :'/users/show'
end

# list of all users
get "/users" do
  ensure_login!
  @users = User.all
  erb :"/users/index"
end

# =============NOT IN USE===============
# return form for editing a user
# get '/users/:id/edit' do
#   @user = User.find_by(id: params[:id])
# end

# # update a specific user
# put '/users/:id' do
#   @user = User.find_by(id: params[:id])
# end

# # delete user permanently
# delete '/users/:id' do
#   @user = User.find_by(id: params[:id])
# end
# ======================================
