class ApplicationController < ActionController::Base
  before_action :set_flash_from_params

  private
  def set_flash_from_params
    flash[:alert] = params[:alert] if params[:alert].present?
    flash[:notice] = params[:notice] if params[:notice].present?
  end
end
