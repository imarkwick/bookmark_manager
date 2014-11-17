require 'sinatra/base'
require 'data_mapper'

	env = ENV["RACK_ENV"] || "development"
	# this tells datamapper to use a postgres database on Localhost
	# the name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
	DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

	require './lib/link' # needs to be done after datamapper is initialised

	# after decaling the models, you should finalise them
	DataMapper.finalize

	# but to create them in the first place
	DataMapper.auto_upgrade!

class MyApp < Sinatra::Base
	set :views, Proc.new { File.join(root, "..", "views") }

  get '/' do
  	@links = Link.all
  	erb :index
  end

  post '/links' do
  	url = params["url"]
  	title = params["title"]
  	Link.create(:url => url, :title => title)
  	redirect to('/')
  end

  get '/tags/:text' do
    tag = Tag.first(:text => params[:text])
    @links = tag ? tag.links : []
    erb :index
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
