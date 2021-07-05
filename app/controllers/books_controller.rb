class BooksController < ApplicationController
   before_action :authenticate_user!
   before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
   @books = Book.all
   @user = current_user
   @book = Book.new
  end

  def show
    @book = Book.new
    @book_comment = BookComment.new
    @book_detail = Book.find(params[:id])
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def update
    @book =Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path
    else
      @user = current_user
      @book_detail = Book.find(params[:id])
      render :edit
    end
  end

   def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
   end




  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
