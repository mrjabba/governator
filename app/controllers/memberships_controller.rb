class MembershipsController < ApplicationController
    
  def new
    @title = "New Membership"    
    @membership = Membership.new(:group_id => params[:group_id])
  end
    
  def create
    @group = Group.find(params[:membership][:group_id])
    @membership = Membership.new(params[:membership])
    if @membership.save
      flash[:success] = "Membership created successfully!"
      redirect_to @group
    else 
      @title = "New Membership"
      render 'new'
    end
  end    

end
