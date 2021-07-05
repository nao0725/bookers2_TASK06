class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @following = User.new
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

  def correct_user
      @user = User.find(params[:id])
      redirect_to user_path(current_user) unless @user == current_user
  end
end

