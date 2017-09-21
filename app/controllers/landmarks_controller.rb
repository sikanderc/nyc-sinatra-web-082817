require "pry"
class LandmarksController < ApplicationController

  set :views, Proc.new { File.join(root, "../views/landmarks") }

  get '/landmarks/new' do
    erb :new
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    # @landmarks = Landmark.all
    erb :index
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :index
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :show
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :edit
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    redirect to "/landmarks/#{@landmark.id}"
  end

  delete '/landmarks/:id' do
    Landmark.destroy(params[:id])
    @landmarks = Landmark.all
    erb :delete
  end

end
