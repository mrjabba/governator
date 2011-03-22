class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "User Repository"
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
    #FIXME how to make this work for both json input param :q and page index search????
    #FIXME how to make this work for both json input param :q and page index search????
    #FIXME how to make this work for both json input param :q and page index search????
    #FIXME need to support either first and last name or an option of one or the other...    
    #yuk
    @json_users = User.where("first_name like ?", "%#{params[:q]}%") if params[:q]
#    TODO combine with not_in_group finder -> @json_users = User.not_in_group(1,params q)

    respond_to do |format|
      format.html
      format.json { render :json => @json_users.map(&:fields)}
    end
    
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
    @appgroup = Appgroup.find(params[:appgroup_id])
    @user = User.new
    @user.appgroup = @appgroup
  end
  
  def create
    @appgroup = Appgroup.find(params[:appgroup_id])
    @user = @appgroup.users.build(params[:user])
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
