class TypesController < ApplicationController
  def new
  end

  def create
  end

  def show
    if logged_in?
      @type = Type.find(params[:id])
      render users_show_race_type_path
    else
      redirect_to '/'
    end
  end

  private 

  def type_params 
    params.require(:type).permit(:name, :distance)
  end
end
