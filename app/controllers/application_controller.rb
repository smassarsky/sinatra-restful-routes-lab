class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    if @recipe
      erb :show
    else
      "Invalid Recipe ID"
    end
  end

  delete '/recipes/:id' do
    Recipe.find(params[:id]).destroy
    redirect "/recipes"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    if @recipe
      erb :edit
    else
      "Invalid Recipe ID"
    end
  end

  patch '/recipes/:id/edit' do
    recipe = Recipe.find(params[:id])
    if recipe
      recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
      redirect "/recipes/#{recipe.id}"
    else
      "Invalid Recipe ID"
    end
  end


end
