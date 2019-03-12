class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:index, :show]
  private
  def require_is_admin
    if !current_user.admin?
      redirect_to jobs_path
      flash[:danger] = '你不是管理员'
    end
  end
end
