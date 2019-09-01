class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.order_asc
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render "new" # note, 'new' template can access @movie's field values!
    end
  end

  # replaces the 'update' method in controller:
  def update
    @movie = Movie.find params[:id]
    if @movie.update_attributes(params[:movie])
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    else
      render "edit" # note, 'edit' template can access @movie's field values!
    end
  end

  # note, you will also have to update the 'new' method:
  def new
    @movie = Movie.new
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def handle_not_found
    flash[:notice] = "Unable to find movie with id #{params[:id]}"
    redirect_to movies_path
  end
end
