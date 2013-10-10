# get '/create_link' do
#   # Look in app/views/index.erb
#   @shortened_links = Url.all
#   erb :short_link
# end

get '/error' do
  erb :error_page
end

get '/created' do
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  url_finder = Url.find_by_shortened_url(params[:short_url])
  Url.update_counters(url_finder.id, :counter => 1)
  redirect to "http://#{url_finder.url}"
end


post '/urls' do
  # create a new Url
  if logged_in?
    if Url.new(url: params[:link]).valid?
      @user = User.find_by_id(current_user.id)
      @url = Url.create(url: params[:link])
      @user.urls << @url
      redirect to "/"
    else
      redirect to "/error"
    end
  else
    Url.new(url: params[:link]).valid?
    @url = Url.create(url: params[:link])
    redirect to "/"
  end
end
