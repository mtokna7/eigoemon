class WordsController < ApplicationController
  def index
    @words = Word.order(:name).all
  end
end
  