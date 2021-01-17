class TypesController < ApplicationController
  before_action :require_logged_in, only: [:new, :create]
  def new
  end

  def create
  end

  def show
    @type = Type.find(params[:id])
    if logged_in?
      render users_show_race_type_path
    else
      render 'show'
    end
  end

  private 

  def type_params 
    params.require(:type).permit(:name, :distance)
  end
end
