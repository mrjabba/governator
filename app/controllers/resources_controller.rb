class ResourcesController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "Resource Repository"
    @resources = Resource.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @resource = Resource.find(params[:id])
    @title = "View Resource | " + @resource.name
  end

  def edit
    @resource = Resource.find(params[:id])
    @title = "Edit Resource"
  end
  
  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(params[:resource])
      flash[:success] = "Resource updated."
      redirect_to @resource
    else
      @title = "Edit Resource"
      render 'edit'
    end    
  end
  
  def new
    @title = "New Resource"
    @app = App.find(params[:app_id])
    @resource = Resource.new
    @resource.app = @app
  end
  
  def create
    @resource = Resource.new(params[:resource])
    if @resource.save
      flash[:success] = "Resource created successfully!"
      redirect_to @resource
    else 
      @title = "New Resource"
      render 'new'
    end
  end    


  private

    def sort_column
      Resource.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
