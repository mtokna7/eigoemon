class WordsController < ApplicationController
  def index
    @words = Word.order(:name).all
  end

  def autocomplete
    query = params[:q]
    words = Word.where('name ILIKE ?', "%#{query}%").limit(10)
    render partial: 'autocomplete_results', locals: { words: words }
  end
end
