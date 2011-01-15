class RolesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "Role Repository"
    @roles = Role.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @role = Role.find(params[:id])
    @title = "View Role | " + @role.name
  end

  def edit
    @role = Role.find(params[:id])
    @title = "Edit Role"
  end
  
  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      flash[:success] = "Role updated."
      redirect_to @role
    else
      @title = "Edit Role"
      render 'edit'
    end    
  end

  def new
    @title = "New Role"
    @app = App.find(params[:app_id])
    @role = Role.new
    @role.app = @app
  end
  
  def create
    @role = Role.new(params[:role])
    if @role.save
      flash[:success] = "Role created successfully!"
      redirect_to @role
    else 
      @title = "New Role"
      render 'new'
    end
  end    


  private

    def sort_column
      Role.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
