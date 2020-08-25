class UsersController < ApplicationController
 before_action :authenticate_user!
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def new
    @user = User.new
  end
  def show
  	@user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'You have updated user successfully.'
      redirect_to user_path(current_user)
    else
      @users = User.all
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    @book.user_id = current_user.id
    @user.save
    redirect_to books_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end

