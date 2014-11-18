require 'sinatra'
require 'data_mapper'
require './models/link'
require './models/tag'
require './models/user'
require 'rack-flash'

  # require_relative 'helpers/application'
  # require_relative 'data_mapper_setup'

	env = ENV["RACK_ENV"] || "development"
	# this tells datamapper to use a postgres database on Localhost
	# the name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
	DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

	# after decaling the models, you should finalise them
	DataMapper.finalize

	# but to create them in the first place
	DataMapper.auto_upgrade!
	
  set :views, Proc.new { File.join(root, "..", "views") }
  enable :sessions
  set :session_secret, 'super secret'
  use Rack::Flash

  get '/' do
  	@links = Link.all
  	erb :index
  end

  post '/links' do
  	url = params["url"]
  	title = params["title"]
    tags = params["tags"].split(" ").map{ |tag| Tag.first_or_create(:text => tag) }
  	Link.create(:url => url, :title => title, :tags => tags)
  	redirect to('/')
  end

  get '/tags/:text' do
    tag = Tag.first(:text => params[:text])
    @links = tag ? tag.links : []
    erb :index
  end

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users/new' do
    @user = User.create(:email => params[:email],
                      :password => params[:password],
                      :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to ('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
     end
  end


helpers do
    def current_user
      @current_user ||=User.get(session[:user_id]) if session[:user_id]
    end
end


