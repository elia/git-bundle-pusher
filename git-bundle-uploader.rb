require 'rubygems'

require 'bundler/setup'
require 'models'



require 'sinatra'
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
  repo.pull(origin)
  repo.pull(params[:file])
  repo.push(origin)
  redirect "/#{repo.name}"
end
