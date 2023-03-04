class BooksController < ApplicationController
  before_action :ensure_correct_book, only: [:update,:edit,:destroy]

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @newbook = Book.new
    @book_comment = BookComment.new
    # 閲覧表示機能
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book.id)
      current_user.view_counts.create(book_id: @book.id)
    end
  end

  def index
    # いいね数のランキング表示
    # to = Time.current.at_end_of_day
    # from = (to - 6.day).at_beginning_of_day
    # @books = Book.includes(:favorites).
    #   sort_by { |x| x.favorites.where(created_at: from...to).size}.reverse
    # @book = Book.new
    
    #降順・昇順・星のカウント数での並び替え
    if params[:latest]
      @books = Book.latest
    elsif params[:old]
      @books = Book.old
    elsif params[:star_count]
      @books = Book.star_count
    else
      @books = Book.all
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title,:body,:rate)
    end

    def ensure_correct_book
      book = Book.find(params[:id])
      unless book.user == current_user
        redirect_to books_path
      end
    end
end