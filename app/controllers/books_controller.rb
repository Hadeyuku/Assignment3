class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
  	@book = Book.new
  	@books = Book.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
  	@books = Book.all
    @user = User.find(@book.user_id)
  end

  def new
     @book = current_user.posts.build
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    @book = current_user.books.build(book_params)
    if @book.save
    flash[:notice] = 'You have creatad book successfully.'
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
   end
 end

  def edit
  	@book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:success] = 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:destroy] = 'book was successfully destroyed'
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
