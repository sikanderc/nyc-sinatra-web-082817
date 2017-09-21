require "pry"
class FiguresController < ApplicationController

  set :views, Proc.new { File.join(root, "../views/figures") }

  get '/figures/new' do
    erb :new
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params['landmark']['name'].empty?
      @figure.landmarks << Landmark.create(name: params['landmark']['name'])
    end
    if !params['title']['name'].empty?
      @figure.titles << Title.create(name: params['title']['name'])
      params['title']['name']
    end
    @figure.save
    erb :index
  end

  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :show
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :edit
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    # redirect to "figures/#{@figure.id}"
    erb :show
  end

  # patch '/figures/:id' do
  #   @figure = Figure.find(params[:id])
  #   @figure.update(name: params[:name])
  #   erb :show
  # end

  delete '/figures/:id' do
    Figure.destroy(params[:id])
    @figures = Figure.all
    erb :index
  end
end
