class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :set_nav

  def after_sign_in_path_for(resource_or_scope)
    "/home"
  end

  def set_nav
    
  end
end
