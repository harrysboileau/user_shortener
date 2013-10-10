get '/' do
  # Look in app/views/index.erb
  @shortened_links = Url.all
  erb :index
end

get '/login' do
  erb :login_homepage
end

get '/secret/:id' do
  if current_user
    erb :secret
  else
    redirect to '/'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to '/'
end


post '/create_user' do
  @user = User.create(params[:user])
  redirect to '/login'
end

post '/login' do
  # We'll have access to data from the form: email and password

  # Try to find a user by e-mail
  @user = User.find_by_email(params[:login][:email])

  # If I found a user with that e-mail address in the database
  if @user
    # I did find a user, does the given password match @user.password
    if @user.authenticate(params[:login][:password])
      # Passwords match, log the user in
      session[:user_id] = @user.id
      # Redirect them somewhere
      redirect to "/secret/#{@user.id}"
    else
      # Passwords didn't match, so redirect
      redirect to '/'
    end
  else
    # Didn't find user, so redirect
    redirect to '/'
  end
end
