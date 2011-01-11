class AppgroupsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "Application Group Repository"
    @appgroups = Appgroup.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @appgroup = Appgroup.find(params[:id])
    @title = "View Application Group | " + @appgroup.name
  end

  def edit
    @appgroup = Appgroup.find(params[:id])
    @title = "Edit Application Group"
  end
  
  def update
    @appgroup = Appgroup.find(params[:id])
    if @appgroup.update_attributes(params[:appgroup])
      flash[:success] = "Application Group updated."
      redirect_to @appgroup
    else
      @title = "Edit Application Group"
      render 'edit'
    end    
  end
  
  def new
    @title = "New Application Group"
    @appgroup = Appgroup.new
  end
  
  def create
    @appgroup = Appgroup.new(params[:appgroup])
    if @appgroup.save
      flash[:success] = "Application Group created successfully!"
      redirect_to @appgroup
    else 
      @title = "New Application Group"
      render 'new'
    end
  end    


  private

    def sort_column
      Appgroup.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
