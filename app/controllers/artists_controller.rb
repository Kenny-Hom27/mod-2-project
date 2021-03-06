class ArtistsController < ApplicationController
  before_action :find_artist, only: [:show, :edit, :destroy, :update]
  def index
    @artists = Artist.sorted
  end

  def show
    @architectures = @artist.architectures.sort_by {|arc| arc.name}
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.name = @artist.name.titleize
    if @artist.save
      redirect_to artist_path(@artist)
    else
      flash[:error] = @artist.errors.full_messages
      redirect_to new_artist_path
    end
  end

  def edit
  end

  def update
    @artist.update(artist_params)
    @artist.name = @artist.name.titleize    
    if @artist.valid?
      redirect_to artist_path(@artist)
    else
      redirect_to edit_artist_path
    end
  end

  def destroy
    @artist.destroy
    redirect_to artists_path
  end

  private

  def find_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name)
  end

end
