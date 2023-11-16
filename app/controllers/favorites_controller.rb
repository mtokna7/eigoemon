class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.for_user(current_user.id)
  end

  def show
    begin
      @favorite = Favorite.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to favorites_path, alert: 'Favorite not found'
    end
  end

  def create
    @word = Word.find(params[:word_id])
    current_user.favorites.create!(word_id: @word.id)
    render turbo_stream: turbo_stream.replace(
      'favorite_button',
      partial: 'favorites/favorite_button',
      locals: { word: @word, favorited: true }
    )
  end

  def destroy
    @word = Word.find(params[:word_id])
    favorite = current_user.favorites.find_by!(word_id: @word.id)
    favorite.destroy!
    render turbo_stream: turbo_stream.replace(
      'favorite_button',
      partial: 'favorites/favorite_button',
      locals: { word: @word, favorited: false }
    )
  end
end
