class TagSearchesController < ApplicationController

  def search
    @word = params[:word]
    @books = Book.where(tag: @word)
    render "searches/result"
  end

end
