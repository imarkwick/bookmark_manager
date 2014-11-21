require 'sinatra'
require 'sinatra/partial'
require 'data_mapper'
require 'rack-flash'

require_relative './models/link'
require_relative './models/tag'
require_relative './models/user'
require_relative 'data_mapper_setup'
require_relative 'helpers/helper'


# set :views, Proc.new { File.join(root, "..", "views") }

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash
set :partial_template_engine, :erb

require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/application'
