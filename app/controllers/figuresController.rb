class FiguresController < ApplicationController

  # Create related
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    @figure = Figure.new(params[:figure])
    if params[:landmark][:name]
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    if params[:title][:name]
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    erb :'figures/show'
  end

  # Retrieve
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  # update related
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
      @figure = Figure.find(params[:id])
      @figure.update (params[:figure])
      if params[:landmark][:name]
        @figure.landmarks << Landmark.create(params[:landmark])
      end
      if params[:title][:name]
        @figure.titles << Title.create(params[:title])
      end
      @figure.save
      redirect :"/figures/#{@figure.id}"
  end

end
