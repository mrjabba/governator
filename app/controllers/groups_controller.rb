class GroupsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @title = "Group Repository"
    @groups = Group.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])    
   end

  def show
    @group = Group.find(params[:id])
    @title = "View Group | " + @group.name
  end

  def edit
    @group = Group.find(params[:id])
    @title = "Edit Group"
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      flash[:success] = "Group updated."
      redirect_to @group
    else
      @title = "Edit Group"
      render 'edit'
    end    
  end
  
  def new
    @title = "New Group"    
    @group = Group.new
  end
  
  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = "Group created successfully!"
      redirect_to @group
    else 
      @title = "New Group"
      render 'new'
    end
  end    

  private

    def sort_column
      Group.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end


end
