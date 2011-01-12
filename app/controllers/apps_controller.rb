class AppsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "Application Repository"
    @apps = App.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @app = App.find(params[:id])
    @title = "View Application | " + @app.name
  end

  def edit
    @app = App.find(params[:id])
    @title = "Edit Application"
  end
  
  def update
    @app = App.find(params[:id])
    if @app.update_attributes(params[:app])
      flash[:success] = "Application updated."
      redirect_to @app
    else
      @title = "Edit Application"
      render 'edit'
    end    
  end
  
  def new
    @title = "New App"    
    @appgroup = Appgroup.find(params[:appgroup_id])
    @app = App.new
    @app.appgroup = @appgroup
  end
  
  def create
    @app = App.new(params[:app])
    if @app.save
      flash[:success] = "Application created successfully!"
      redirect_to @app
    else 
      @title = "New Application"
      render 'new'
    end
  end    


  private

    def sort_column
      App.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
