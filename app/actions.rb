# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all.sort_by { |track| track.votes.count }.reverse

  @users = User.all

  erb :'tracks/index'
end

get '/tracks/new' do
  redirect '/sessions/login' if session[:id].nil?
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
    song_title: params[:song_title],
    artist: params[:artist],
    url:  params[:url],
    user_id: session[:id]
  )

  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/song_by_artist/:artist' do
  @tracks = Track.where(artist: params[:artist])
  erb :'tracks/song_by_artist'
end

get '/registrations/signup' do
  erb :'/registrations/signup'
end

post '/registrations' do
  @user = User.new(first_name: params["first_name"], last_name: params["last_name"], user_name: params["user_name"], password: params["password"])

  if @user.save
    
    session[:id] = @user.id
    redirect '/users/home'
  else
    erb :'/registrations/signup'
  end
end

get '/users/home' do
  redirect '/sessions/login' unless session[:id]

  @user = User.find(session[:id])
  @tracks = Track.where(user_id: @user.id)

  erb :'/users/home'
end

get '/sessions/login' do #/login
  if session[:id]
    redirect '/users/home'
  else
  
    erb :'sessions/login'
  end
end

post '/sessions' do
  user_name = params[:user_name]
  password = params[:password]

  user = User.find_by(user_name: user_name).try(:authenticate, password)

  if user
    session.delete(:login_error) # Login successful, delete login error message
    session[:id] = user.id
    redirect '/users/home'
  else
    session.delete(:id) # Just to make sure we're logged out
    session[:login_error] = "Invalid Credentials"
    redirect '/sessions/login'
  end
end

get '/sessions/logout' do
  session.clear
  redirect '/'
end

post '/vote' do
  track_id = params[:track_id]

  vote = Vote.new(user_id: session[:id], track_id: track_id)
  
  vote.save
  
  redirect '/tracks'
end













