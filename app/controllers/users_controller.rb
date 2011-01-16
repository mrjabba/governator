class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "User Repository"
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @user = User.find(params[:id])
    @title = "View User | " + @user.username
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated."
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end    
  end
  
  def new
    @title = "New User"    
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User created successfully!"
      redirect_to @user
    else 
      @title = "New User"
      render 'new'
    end
  end    

  private

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "username"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end



end
