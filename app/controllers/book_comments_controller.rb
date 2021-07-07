class BookCommentsController < ApplicationController

  def create
    @book_detail = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book = @book_detail
    @book_comment.save
    # redirect_to book_path(@book_detail)
  end

  def destroy
    @book_detail = Book.find(params[:book_id])
    @book_comments = @book_detail.book_comments
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    # redirect_to book_path(params[:book_id])
  end


    private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
