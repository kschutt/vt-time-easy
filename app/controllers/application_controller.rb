class ApplicationController < ActionController::Base
  protect_from_forgery
  # before_filter :authenticate_user!
    rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path
  end
end
