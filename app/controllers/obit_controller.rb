class ObitController < ApplicationController

  before_action :authenticate_user!

  def index
    @obits = current_user.obits 
  end

  def new
    @obit = Obit.new
  end

  def create
    @obit = Obit.new(obit_params);
    @obit.user_id = current_user.id.to_i

    if @obit.save
      redirect_to action: 'show', id: @obit.id
    else
      flash[:error] = "Error creating" + @obit.to_s
      redirect_to action: 'new'
    end
  end

  def show
    @obituary = Obit.find_by_user_id_and_id(current_user.id, params[:id])
  end

  def update
    begin
      obituary = Obit.find_by_user_id_and_id(current_user.id, params[:id])
      obituary.update(obit_params)
      render :json => obituary
    rescue ActiveRecord::RecordNotFound => e
      render :json => { :error => "Unable to find obituary" } 
    end

  end

  def destroy
    begin
      obituary = Obit.find_by_user_id_and_id(current_user.id, :params[:id])
      obituary.destroy
      render :json => { :status => "Obituary Removed" }
    rescue ActiveRecord::RecordNotFound => e
      render :json => { :error => "Unable to find obituary" } 
    end
  end

  private

  def obit_params
    params.require(:obit).permit(:name, :obituary, :img_link)
  end
end
