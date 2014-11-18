require 'sinatra'
require 'data_mapper'
require './models/link'
require './models/tag'

	env = ENV["RACK_ENV"] || "development"
	# this tells datamapper to use a postgres database on Localhost
	# the name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
	DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

	# after decaling the models, you should finalise them
	DataMapper.finalize

	# but to create them in the first place
	DataMapper.auto_upgrade!
	
  set :views, Proc.new { File.join(root, "..", "views") }

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

