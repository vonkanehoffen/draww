class ApplicationController < ActionController::Base

  require_dependency "#{Rails.application.root}/lib/user_sanitizer.rb"

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout Proc.new { |controller| controller.request.xhr? ? "popup" : "application" }

  protected
 
  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
