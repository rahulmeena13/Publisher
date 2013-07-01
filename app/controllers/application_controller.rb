class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end
  
  def devise_parameter_sanitizer
    if(resource_class.is_a?(User))
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
