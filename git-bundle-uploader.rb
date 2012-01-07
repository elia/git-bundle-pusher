require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'haml'

require 'models'

helpers do
  def repo
    @repo ||= Repo.where(name: params[:name]).first or halt 404
  end
end


get '/' do
  haml :new
end

post '/' do
  Repo.create!(params[:repo])
  redirect "/#{repo.name}"
end

get '/:name' do
  haml :show
end

post '/:name/push' do
  repo.pull(params[:update][:tempfile].path)
  repo.push
  
  redirect "/#{repo.name}"
end
