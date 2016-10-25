class BooksController < ApplicationController
  require 'fcm'
  autocomplete :sub_category, :name
  autocomplete :user, :first_name, :extra_data => [:last_name], :display_value => :name
  def index
    category = Category.find(params[:category_id])
    @books = category.books.paginate(:page => params[:page]).order("id").per_page(10)
  end

  def show
    @category = Category.find(params[:category_id])
    @book = @category.books.find(params[:id])
  end

  def search
    @books = Book.search_by_name(params[:search])
  end

  def new
    @category = Category.find(params[:category_id])
    @book = @category.books.build
  end

  def create
    @category = Category.find(params[:category_id])
    @book = @category.books.build(book_params)
    if @book.save
      redirect_to category_book_path(@book.category_id, @book)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to category_book_path(@book.category_id, @book)
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @book = @category.books.find(params[:id])
    @book.destroy
    redirect_to root_path
  end

  def need_approval
    @books = Book.where(approved: false)
  end

  def books_borrows
    @books = Book.where(approved: true)
  end

  def control_approval
    @book = Book.find(params[:id])
    if @book.approved == false
       @book.approved = true
       user = User.find(@book.owner_id)
        send_notification(user.fcm_token, @book.name, user.id)
    else
       @book.approved = false
    end
    if @book.save
      redirect_to books_need_approval_path
    end
  end

  def subscribe
    @book = Book.find(params[:id])
    if @book.available 
        @book.borrow_date = Date.today
        @book.borrow_times = @book.borrow_times + 1
        @book.approved = true
        @book.available = false
        user = User.find(@book.owner_id)
        send_notification(user.fcm_token, @book.name, user.id)
        if @book.save
          redirect_to edit_category_book_path(@book.category_id, @book)
        end
    end
  end

  def unsubscribe
    @book = Book.find(params[:id])
        @book.subscriber_id = nil
        @book.borrow_times = @book.borrow_times - 1 if @book.borrow_date == Date.today
        @book.borrow_date = nil
        @book.approved = nil
        @book.available = true
        if @book.save
          redirect_to category_book_path(@book.category_id, @book)
        end
  end

  private
  def book_params
    params.require("book").permit(:book_id, :name, :author, :translator, :num_of_pages, :page_size, :publishing_house, :group, :available, :category_id, :sub_category_id, :owner_id, :subscriber_id)
  end

  def send_notification(notification_dest, book_name, user_id)
    fcm = FCM.new("AIzaSyC7EB-g9d49wRC-Ki7UiPy5qry0QOWw4SE")
    registration_ids= [notification_dest] # an array of one or more client registration tokens
    options = {notification: {body: "تم طلب الكتاب -#{book_name}- للاستعارة"}}
    puts response = fcm.send(registration_ids, options)

    Notification.create(title: "كتاب مطلوب للاستعارة", content: "تم طلب الكتاب -#{book_name}- للاستعارة", date: Date.today, user_id: user_id)
  end

end
